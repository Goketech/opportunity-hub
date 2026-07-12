import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/data/auth_repository.dart';
import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';
import 'package:opportunity_hub/features/auth/presentation/state/auth_state.dart';
import 'package:opportunity_hub/features/startups/data/startup_repository.dart';

final authNotifierProvider =
    AsyncNotifierProvider<AuthNotifier, AuthState>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<AuthState> {
  StreamSubscription<User?>? _authSubscription;

  AuthRepository get _repository => ref.read(authRepositoryProvider);
  StartupRepository get _startupRepository => ref.read(startupRepositoryProvider);

  @override
  Future<AuthState> build() async {
    _authSubscription ??= _repository.authStateChanges().listen((_) async {
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
    state = const AsyncData(AuthLoading());
    state = await AsyncValue.guard(() async {
      await _repository.signIn(email: email, password: password);
      return _resolveCurrentState();
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncData(AuthLoading());
    state = await AsyncValue.guard(() async {
      await _repository.signUp(email: email, password: password);
      return _resolveCurrentState();
    });
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
      return const AuthUnauthenticated();
    }

    final profile = await _repository.fetchUserProfile(activeUser.uid);
    if (profile == null || !profile.isProfileComplete) {
      return AuthOnboardingRequired(uid: activeUser.uid, email: activeUser.email!);
    }

    return AuthAuthenticated(profile);
  }
}
