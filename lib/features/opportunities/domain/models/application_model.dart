import 'package:cloud_firestore/cloud_firestore.dart';

enum ApplicationStatus { submitted, reviewed, accepted, rejected, withdrawn }

class ApplicationModel {
  final String id;
  final String opportunityId;
  final String studentId;
  final String startupId;
  final Map<String, String> answers;
  final ApplicationStatus status;
  final DateTime appliedAt;
  final DateTime? reviewedAt;
  final String? reviewNotes;

  ApplicationModel({
    required this.id,
    required this.opportunityId,
    required this.studentId,
    required this.startupId,
    required this.answers,
    required this.status,
    required this.appliedAt,
    this.reviewedAt,
    this.reviewNotes,
  });

  factory ApplicationModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ApplicationModel(
      id: doc.id,
      opportunityId: data['opportunityId'] as String,
      studentId: data['studentId'] as String,
      startupId: data['startupId'] as String,
      answers: Map<String, String>.from(data['answers'] as Map),
      status: ApplicationStatus.values.byName(data['status'] as String),
      appliedAt: (data['appliedAt'] as Timestamp).toDate(),
      reviewedAt: data['reviewedAt'] != null ? (data['reviewedAt'] as Timestamp).toDate() : null,
      reviewNotes: data['reviewNotes'] as String?,
    );
  }

  Map<String, dynamic> toFirestore() => {
    'opportunityId': opportunityId,
    'studentId': studentId,
    'startupId': startupId,
    'answers': answers,
    'status': status.name,
    'appliedAt': appliedAt,
    'reviewedAt': reviewedAt,
    'reviewNotes': reviewNotes,
  };
}
