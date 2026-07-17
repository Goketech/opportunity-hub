import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepository {
  AuthRepository({required FirebaseAuth auth, required FirebaseFirestore firestore})
    : _auth = auth,
      _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  static const List<String> _allowedDomains = ['alueducation.com', 'alu.edu', 'alustudent.com'];

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  void _log(String message) {
    debugPrint('[AuthRepository] $message');
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      _log('signIn start for email=$email');
      _enforceAluEmail(email);
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      final activeEmail = _auth.currentUser?.email ?? '';
      if (!_isAluEmail(activeEmail)) {
        await _auth.signOut();
        throw FirebaseAuthException(
          code: 'invalid-domain',
          message: 'Only ALU email domains are allowed.',
        );
      }
      _log('signIn success uid=${_auth.currentUser?.uid}');
    } on FirebaseAuthException catch (error) {
      _log(
        'signIn FirebaseAuthException code=${error.code} message=${error.message}',
      );
      throw _withActionableMessage(error, operation: 'signIn');
    }
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    try {
      _log('signUp start for email=$email');
      _enforceAluEmail(email);
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(),
        password: password,
      );
      _log('signUp success uid=${credential.user?.uid}');
      return credential;
    } on FirebaseAuthException catch (error) {
      _log(
        'signUp FirebaseAuthException code=${error.code} message=${error.message}',
      );
      throw _withActionableMessage(error, operation: 'signUp');
    }
  }

  FirebaseAuthException _withActionableMessage(
    FirebaseAuthException error, {
    required String operation,
  }) {
    if (error.code != 'internal-error') {
      return error;
    }

    final original = error.message ?? 'No message from Firebase Auth iOS SDK.';
    return FirebaseAuthException(
      code: error.code,
      message:
          'Firebase Authentication internal-error during $operation. '
          'Check Firebase Console: Authentication is enabled, Email/Password sign-in is enabled, '
          'and iOS app bundle id matches GoogleService-Info.plist. Original: $original',
    );
  }

  Future<void> signOut() => _auth.signOut();

  Future<UserProfile?> fetchUserProfile(String uid) async {
    try {
      _log('fetchUserProfile start uid=$uid');
      final snapshot = await _firestore.collection('users').doc(uid).get();
      if (!snapshot.exists) {
        _log('fetchUserProfile no document for uid=$uid');
        return null;
      }

      final data = snapshot.data();
      if (data == null) {
        _log('fetchUserProfile empty data for uid=$uid');
        return null;
      }

      _log('fetchUserProfile success uid=$uid');
      return UserProfile.fromJson({'id': uid, ...data});
    } on FirebaseException catch (error) {
      _log(
        'fetchUserProfile FirebaseException code=${error.code} message=${error.message}',
      );
      rethrow;
    }
  }

  Future<void> completeStudentOnboarding({
    required String uid,
    required String email,
    required String fullName,
    required String bio,
    required List<String> skills,
  }) async {
    _enforceAluEmail(email);

    final now = DateTime.now().toUtc();
    final existing = await fetchUserProfile(uid);

    final profile = UserProfile(
      id: uid,
      role: UserRole.student,
      fullName: fullName,
      aluEmail: email.toLowerCase(),
      bio: bio,
      skills: skills,
      portfolioUrls: existing?.portfolioUrls ?? const <String>[],
      avatarUrl: existing?.avatarUrl,
      isProfileComplete: true,
      startupId: null,
      startupVerificationMethod: null,
      startupVerificationReference: null,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    await _firestore.collection('users').doc(uid).set(profile.toJson(), SetOptions(merge: true));
  }

  Future<void> completeFounderOnboarding({
    required String uid,
    required String email,
    required String fullName,
    required String bio,
    required List<String> skills,
    required StartupVerificationMethod verificationMethod,
    required String verificationCode,
  }) async {
    _enforceAluEmail(email);
    final normalizedCode = verificationCode.trim().toUpperCase();

    await _validateFounderVerification(
      verificationMethod: verificationMethod,
      verificationCode: normalizedCode,
    );

    final now = DateTime.now().toUtc();
    final existing = await fetchUserProfile(uid);

    final profile = UserProfile(
      id: uid,
      role: UserRole.startupFounder,
      fullName: fullName,
      aluEmail: email.toLowerCase(),
      bio: bio,
      skills: skills,
      portfolioUrls: existing?.portfolioUrls ?? const <String>[],
      avatarUrl: existing?.avatarUrl,
      isProfileComplete: true,
      startupId: existing?.startupId,
      startupVerificationMethod: verificationMethod,
      startupVerificationReference: normalizedCode,
      createdAt: existing?.createdAt ?? now,
      updatedAt: now,
    );

    await _firestore.collection('users').doc(uid).set(profile.toJson(), SetOptions(merge: true));
  }

  Future<void> _validateFounderVerification({
    required StartupVerificationMethod verificationMethod,
    required String verificationCode,
  }) async {
    final doc = await _firestore
        .collection('startup_verification_registry')
        .doc(verificationCode)
        .get();

    if (!doc.exists) {
      throw FirebaseAuthException(
        code: 'verification-not-found',
        message: 'Invalid venture tracking ID or approval token.',
      );
    }

    final data = doc.data() ?? <String, dynamic>{};
    final expectedType = verificationMethod == StartupVerificationMethod.ventureTrackingId
        ? 'venture_tracking_id'
        : 'approval_token';
    final typeMatches = data['type'] == expectedType;
    final isActive = data['isActive'] == true;

    if (!typeMatches || !isActive) {
      throw FirebaseAuthException(
        code: 'verification-invalid',
        message: 'Provided verification credential is not eligible.',
      );
    }
  }

  static bool _isAluEmail(String email) {
    final normalized = email.trim().toLowerCase();
    return _allowedDomains.any((domain) => normalized.endsWith('@$domain'));
  }

  static void _enforceAluEmail(String email) {
    if (!_isAluEmail(email)) {
      throw FirebaseAuthException(
        code: 'invalid-domain',
        message: 'Use an ALU email ending with @alueducation.com or @alu.edu.',
      );
    }
  }
}
