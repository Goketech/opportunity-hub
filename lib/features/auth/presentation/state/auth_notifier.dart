import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/data/auth_repository.dart';
import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/startups/data/startup_repository.dart';

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  StreamSubscription<User?>? _authSubscription;
  bool _authActionInFlight = false;

  AuthRepository get _repository => ref.read(authRepositoryProvider);
  StartupRepository get _startupRepository => ref.read(startupRepositoryProvider);

  void _log(String message) {
    debugPrint('[AuthNotifier] $message');
  }

  @override
  Future<AuthState> build() async {
    _log('build start');
    _authSubscription ??= _repository.authStateChanges().listen((_) async {
      if (_authActionInFlight) {
        _log('authStateChanges ignored because auth action is in flight');
        return;
      }

      _log('authStateChanges received - resolving current state');
      state = const AsyncLoading();
      state = await AsyncValue.guard(_resolveCurrentState);
    });

    ref.onDispose(() async {
      await _authSubscription?.cancel();
      _authSubscription = null;
    });

    return _resolveCurrentState();
  }

  Future<void> signIn({required String email, required String password}) async {
    _log('signIn start for email=$email');
    _authActionInFlight = true;
    state = const AsyncData(AuthLoading());
    try {
      state = await AsyncValue.guard(() async {
        await _repository.signIn(email: email, password: password);
        final next = await _resolveCurrentState();
        _log('signIn resolved to ${next.runtimeType}');
        return next;
      });
      if (state.hasError) {
        _log('signIn failed error=${state.error} stack=${state.stackTrace}');
      }
    } finally {
      _authActionInFlight = false;
      _log('signIn end');
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    _log('signUp start for email=$email');
    _authActionInFlight = true;
    state = const AsyncData(AuthLoading());
    try {
      state = await AsyncValue.guard(() async {
        final credential = await _repository.signUp(email: email, password: password);
        final signedUpUser = credential.user ?? _repository.currentUser;

        if (signedUpUser == null || signedUpUser.email == null) {
          _log('signUp completed without a signed-in user');
          return const AuthUnauthenticated();
        }

        _log('signUp success uid=${signedUpUser.uid}, routing to onboarding');
        return AuthOnboardingRequired(
          uid: signedUpUser.uid,
          email: signedUpUser.email!,
        );
      });
      if (state.hasError) {
        _log('signUp failed error=${state.error} stack=${state.stackTrace}');
      }
    } finally {
      _authActionInFlight = false;
      _log('signUp end');
    }
  }

  Future<void> completeStudentOnboarding({
    required String fullName,
    required String bio,
    required List<String> skills,
  }) async {
    final activeUser = _repository.currentUser;
    if (activeUser == null || activeUser.email == null) {
      state = const AsyncData(AuthUnauthenticated());
      return;
    }

    state = const AsyncData(AuthLoading());
    state = await AsyncValue.guard(() async {
      await _repository.completeStudentOnboarding(
        uid: activeUser.uid,
        email: activeUser.email!,
        fullName: fullName,
        bio: bio,
        skills: skills,
      );
      return _resolveCurrentState();
    });
  }

  Future<void> completeFounderOnboarding({
    required String fullName,
    required String bio,
    required List<String> skills,
    required StartupVerificationMethod verificationMethod,
    required String verificationCode,
  }) async {
    final activeUser = _repository.currentUser;
    if (activeUser == null || activeUser.email == null) {
      state = const AsyncData(AuthUnauthenticated());
      return;
    }

    state = const AsyncData(AuthLoading());
    state = await AsyncValue.guard(() async {
      await _repository.completeFounderOnboarding(
        uid: activeUser.uid,
        email: activeUser.email!,
        fullName: fullName,
        bio: bio,
        skills: skills,
        verificationMethod: verificationMethod,
        verificationCode: verificationCode,
      );
      return _resolveCurrentState();
    });
  }

  Future<void> signOut() async {
    state = const AsyncData(AuthLoading());
    state = await AsyncValue.guard(() async {
      await _repository.signOut();
      return const AuthUnauthenticated();
    });
  }

  Future<void> completeFounderStartupSetup({
    required String startupName,
    required String logoUrl,
    required int teamSize,
    required List<String> categories,
    required String description,
  }) async {
    final activeUser = _repository.currentUser;
    if (activeUser == null) {
      state = const AsyncData(AuthUnauthenticated());
      return;
    }

    final current = state.valueOrNull;
    if (current is! AuthAuthenticated ||
        current.profile.role != UserRole.startupFounder) {
      throw StateError('Founder authentication context is required.');
    }

    state = const AsyncData(AuthLoading());
    state = await AsyncValue.guard(() async {
      await _startupRepository.createStartupForFounder(
        founderUid: activeUser.uid,
        founderProfile: current.profile,
        startupName: startupName,
        logoUrl: logoUrl,
        teamSize: teamSize,
        description: description,
        categories: categories,
      );

      return _resolveCurrentState();
    });
  }

  Future<AuthState> _resolveCurrentState() async {
    final activeUser = _repository.currentUser;
    if (activeUser == null || activeUser.email == null) {
      _log('resolveCurrentState -> AuthUnauthenticated');
      return const AuthUnauthenticated();
    }

    _log('resolveCurrentState for uid=${activeUser.uid}');
    try {
      final profile = await _repository
          .fetchUserProfile(activeUser.uid)
          .timeout(const Duration(seconds: 8));
      if (profile == null || !profile.isProfileComplete) {
        _log('resolveCurrentState -> AuthOnboardingRequired (missing/incomplete profile)');
        return AuthOnboardingRequired(uid: activeUser.uid, email: activeUser.email!);
      }

      _log('resolveCurrentState -> AuthAuthenticated');
      return AuthAuthenticated(profile);
    } on FirebaseException catch (error) {
      _log(
        'resolveCurrentState FirebaseException code=${error.code} message=${error.message}; fallback to onboarding',
      );
      return AuthOnboardingRequired(uid: activeUser.uid, email: activeUser.email!);
    } on TimeoutException {
      _log('resolveCurrentState timeout; fallback to onboarding');
      return AuthOnboardingRequired(uid: activeUser.uid, email: activeUser.email!);
    }
  }
}
