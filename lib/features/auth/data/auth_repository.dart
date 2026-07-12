import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  static const List<String> _allowedDomains = ['alueducation.com', 'alu.edu'];

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> signIn({required String email, required String password}) async {
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
  }

  Future<void> signUp({required String email, required String password}) async {
    _enforceAluEmail(email);
    await _auth.createUserWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
  }

  Future<void> signOut() => _auth.signOut();

  Future<UserProfile?> fetchUserProfile(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    if (!snapshot.exists) {
      return null;
    }

    final data = snapshot.data();
    if (data == null) {
      return null;
    }

    return UserProfile.fromJson({'id': uid, ...data});
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
