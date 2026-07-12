import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/auth/domain/models/user_profile.dart';
import 'package:opportunity_hub/features/startups/domain/models/startup_model.dart';
import 'package:uuid/uuid.dart';

final startupRepositoryProvider = Provider<StartupRepository>((ref) {
  return StartupRepository(firestore: FirebaseFirestore.instance);
});

class StartupRepository {
  StartupRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  final FirebaseFirestore _firestore;
  static const _uuid = Uuid();

  Future<String> createStartupForFounder({
    required String founderUid,
    required UserProfile founderProfile,
    required String startupName,
    required String logoUrl,
    required int teamSize,
    required String description,
    required List<String> categories,
  }) async {
    final startupId = _uuid.v4();
    final now = DateTime.now().toUtc();

    final startup = StartupModel(
      id: startupId,
      name: startupName,
      logoUrl: logoUrl,
      isAluVerified: true,
      founderIds: [founderUid],
      teamSize: teamSize,
      description: description,
      categories: categories,
      status: 'active',
      createdAt: now,
      updatedAt: now,
    );

    final userRef = _firestore.collection('users').doc(founderUid);
    final startupRef = _firestore.collection('startups').doc(startupId);

    await _firestore.runTransaction((transaction) async {
      final founderSnapshot = await transaction.get(userRef);
      final founderData = founderSnapshot.data();
      final startupLinked = founderData?['startupId'];
      if (startupLinked is String && startupLinked.isNotEmpty) {
        throw StateError('Founder already linked to an existing startup.');
      }

      transaction.set(startupRef, startup.toJson());
      transaction.update(userRef, {
        'startupId': startupId,
        'updatedAt': Timestamp.fromDate(now),
      });
    });

    final verificationReference = founderProfile.startupVerificationReference;
    if (verificationReference != null && verificationReference.isNotEmpty) {
      await _firestore
          .collection('startup_verification_registry')
          .doc(verificationReference)
          .set({
            'isActive': false,
            'consumedBy': founderUid,
            'consumedAt': Timestamp.fromDate(now),
            'startupId': startupId,
          }, SetOptions(merge: true));
    }

    return startupId;
  }
}
