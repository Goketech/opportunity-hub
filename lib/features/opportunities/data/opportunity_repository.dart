import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/application_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/founder_metrics_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_model.dart';
import 'package:opportunity_hub/features/opportunities/domain/models/opportunity_view_model.dart';
import 'package:opportunity_hub/features/opportunities/presentation/state/opportunity_filters.dart';
import 'package:uuid/uuid.dart';

final opportunityRepositoryProvider = Provider<OpportunityRepository>((ref) {
  return OpportunityRepository(firestore: FirebaseFirestore.instance);
});

class OpportunityRepository {
  OpportunityRepository({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const _uuid = Uuid();
  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _opportunities =>
      _firestore.collection('opportunities');

  CollectionReference<Map<String, dynamic>> get _startups =>
      _firestore.collection('startups');

  Future<void> createOpportunity({
    required String startupId,
    required String title,
    required String category,
    required String description,
    required List<String> requiredSkills,
    required String duration,
    required CompensationType compensationType,
    required List<String> screeningQuestions,
  }) async {
    final now = DateTime.now().toUtc();
    final id = _uuid.v4();

    final opportunity = OpportunityModel(
      id: id,
      startupId: startupId,
      title: title,
      category: category,
      description: description,
      requirements: requiredSkills,
      duration: duration,
      compensationType: compensationType,
      screeningQuestions: screeningQuestions,
      isOpen: true,
      createdAt: now,
      updatedAt: now,
    );

    await _opportunities.doc(id).set(opportunity.toJson());
  }

  Stream<List<OpportunityViewModel>> streamOpportunities({
    required OpportunityFilterState filters,
  }) async* {
    var query = _opportunities.where('isOpen', isEqualTo: true);

    if (filters.category != null && filters.category!.isNotEmpty) {
      query = query.where('category', isEqualTo: filters.category);
    }

    final normalizedSkills = filters.requiredSkills
        .map((skill) => skill.trim())
        .where((skill) => skill.isNotEmpty)
        .map((skill) => skill.toLowerCase())
        .toList();

    if (normalizedSkills.length == 1) {
      query = query.where('requirements', arrayContains: normalizedSkills.first);
    } else if (normalizedSkills.length > 1) {
      query = query.where(
        'requirements',
        arrayContainsAny: normalizedSkills.take(10).toList(),
      );
    }

    final verifiedStartupIds =
        await _fetchStartupIdsByVerification(filters.verificationFilter);
    if (verifiedStartupIds != null && verifiedStartupIds.isEmpty) {
      yield const <OpportunityViewModel>[];
      return;
    }

    if (verifiedStartupIds != null &&
        verifiedStartupIds.isNotEmpty &&
        verifiedStartupIds.length <= 10 &&
        filters.verificationFilter == StartupVerificationFilter.aluVerifiedOnly) {
      query = query.where('startupId', whereIn: verifiedStartupIds);
    }

    final snapshots = query.snapshots();

    await for (final snapshot in snapshots) {
      final opportunities = snapshot.docs
          .map((doc) => OpportunityModel.fromJson(doc.data()))
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final startupIds = opportunities
          .map((item) => item.startupId)
          .toSet()
          .toList(growable: false);

      final startupDocs = await Future.wait(
        startupIds.map((id) => _startups.doc(id).get()),
      );

      final startupData = <String, Map<String, dynamic>>{};
      for (final doc in startupDocs) {
        if (doc.exists && doc.data() != null) {
          startupData[doc.id] = doc.data()!;
        }
      }

      var viewModels = opportunities.map((opportunity) {
        final startup = startupData[opportunity.startupId] ?? const <String, dynamic>{};
        final isAluVerified = startup['isAluVerified'] == true;
        return OpportunityViewModel(
          opportunity: opportunity,
          startupName: (startup['name'] as String?) ?? 'Unknown Startup',
          startupLogoUrl: (startup['logoUrl'] as String?) ?? '',
          isStartupAluVerified: isAluVerified,
        );
      }).toList();

      viewModels = _applyClientSideFilters(viewModels, filters);
      yield viewModels;
    }
  }

  Stream<List<OpportunityModel>> streamStartupOpportunities({
    required String startupId,
  }) {
    return _opportunities
        .where('startupId', isEqualTo: startupId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OpportunityModel.fromJson(doc.data()))
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt)),
        );
  }

  Future<List<String>?> _fetchStartupIdsByVerification(
    StartupVerificationFilter filter,
  ) async {
    if (filter == StartupVerificationFilter.all) {
      return null;
    }

    final isVerified = filter == StartupVerificationFilter.aluVerifiedOnly;
    final snapshot = await _startups
        .where('isAluVerified', isEqualTo: isVerified)
        .get();

    return snapshot.docs.map((doc) => doc.id).toList();
  }

  List<OpportunityViewModel> _applyClientSideFilters(
    List<OpportunityViewModel> opportunities,
    OpportunityFilterState filters,
  ) {
    final searchTerm = filters.searchTerm.trim().toLowerCase();

    return opportunities.where((item) {
      final matchesVerification = switch (filters.verificationFilter) {
        StartupVerificationFilter.all => true,
        StartupVerificationFilter.aluVerifiedOnly => item.isStartupAluVerified,
        StartupVerificationFilter.notVerified => !item.isStartupAluVerified,
      };

      final matchesSearch = searchTerm.isEmpty ||
          item.opportunity.title.toLowerCase().contains(searchTerm) ||
          item.opportunity.description.toLowerCase().contains(searchTerm) ||
          item.startupName.toLowerCase().contains(searchTerm);

      final requiredSkills = filters.requiredSkills
          .map((skill) => skill.trim().toLowerCase())
          .where((skill) => skill.isNotEmpty)
          .toSet();
      final opportunitySkills = item.opportunity.requirements
          .map((skill) => skill.trim().toLowerCase())
          .toSet();
      final matchesSkills =
          requiredSkills.isEmpty || requiredSkills.any(opportunitySkills.contains);

      return matchesVerification && matchesSearch && matchesSkills;
    }).toList();
  }

  CollectionReference<Map<String, dynamic>> get _applications =>
      _firestore.collection('applications');

    CollectionReference<Map<String, dynamic>> get _startupMetrics =>
      _firestore.collection('startup_metrics');

      CollectionReference<Map<String, dynamic>> get _opportunityViewEvents =>
        _firestore.collection('opportunity_view_events');

  Future<void> submitApplication({
    required String opportunityId,
    required String studentId,
    required String startupId,
    required Map<String, String> answers,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();

    final application = ApplicationModel(
      id: id,
      opportunityId: opportunityId,
      studentId: studentId,
      startupId: startupId,
      answers: answers,
      status: ApplicationStatus.submitted,
      appliedAt: now,
    );

    await _applications.doc(id).set(application.toFirestore());
    await _incrementStartupCounter(startupId: startupId, field: 'totalApplications');
  }

  Future<void> incrementOpportunityViewCount({
    required String startupId,
    required String opportunityId,
    required String viewerId,
    required String viewDateKey,
  }) async {
    final trackingId = '${opportunityId}_${viewerId}_$viewDateKey';
    final trackingDoc = _opportunityViewEvents.doc(trackingId);
    final metricsDoc = _startupMetrics.doc(startupId);

    await _firestore.runTransaction((transaction) async {
      final existing = await transaction.get(trackingDoc);
      if (existing.exists) {
        return;
      }

      transaction.set(trackingDoc, {
        'id': trackingId,
        'startupId': startupId,
        'opportunityId': opportunityId,
        'viewerId': viewerId,
        'viewDateKey': viewDateKey,
        'createdAt': FieldValue.serverTimestamp(),
      });

      transaction.set(metricsDoc, {
        'startupId': startupId,
        'totalViews': FieldValue.increment(1),
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    });
  }

  Stream<FounderMetricsModel> streamStartupMetrics({
    required String startupId,
  }) {
    return _startupMetrics.doc(startupId).snapshots().map((snapshot) {
      final data = snapshot.data();
      return FounderMetricsModel(
        startupId: startupId,
        totalViews: (data?['totalViews'] as num?)?.toInt() ?? 0,
        totalApplications: (data?['totalApplications'] as num?)?.toInt() ?? 0,
      );
    });
  }

  Stream<List<ApplicationModel>> streamStudentApplications({
    required String studentId,
  }) {
    return _applications
        .where('studentId', isEqualTo: studentId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ApplicationModel.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>))
              .toList()
            ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt)),
        );
  }

  Stream<List<ApplicationModel>> streamOpportunityApplications({
    required String opportunityId,
  }) {
    return _applications
        .where('opportunityId', isEqualTo: opportunityId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ApplicationModel.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>))
              .toList()
            ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt)),
        );
  }

  Future<ApplicationModel?> getStudentApplicationForOpportunity({
    required String studentId,
    required String opportunityId,
  }) async {
    final snapshot = await _applications
        .where('studentId', isEqualTo: studentId)
        .where('opportunityId', isEqualTo: opportunityId)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null;
    }

    return ApplicationModel.fromFirestore(
        snapshot.docs.first as DocumentSnapshot<Map<String, dynamic>>);
  }

  Stream<List<ApplicationModel>> streamStartupApplications({
    required String startupId,
  }) {
    return _applications
        .where('startupId', isEqualTo: startupId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ApplicationModel.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>))
              .toList()
            ..sort((a, b) => b.appliedAt.compareTo(a.appliedAt)),
        );
  }

  Future<void> updateApplicationStatus({
    required String applicationId,
    required ApplicationStatus newStatus,
    String? reviewNotes,
  }) async {
    final now = DateTime.now().toUtc();
    final updateData = <String, dynamic>{
      'status': newStatus.name,
      'reviewedAt': now,
      // ignore: use_null_aware_elements
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
    };
    await _applications.doc(applicationId).update(updateData);
  }

  Future<void> _incrementStartupCounter({
    required String startupId,
    required String field,
  }) async {
    await _startupMetrics.doc(startupId).set({
      'startupId': startupId,
      field: FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
