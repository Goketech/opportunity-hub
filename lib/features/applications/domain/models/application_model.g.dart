// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScreeningAnswerImpl _$$ScreeningAnswerImplFromJson(
  Map<String, dynamic> json,
) => _$ScreeningAnswerImpl(
  question: json['question'] as String,
  answer: json['answer'] as String,
);

Map<String, dynamic> _$$ScreeningAnswerImplToJson(
  _$ScreeningAnswerImpl instance,
) => <String, dynamic>{
  'question': instance.question,
  'answer': instance.answer,
};

_$ApplicationModelImpl _$$ApplicationModelImplFromJson(
  Map<String, dynamic> json,
) => _$ApplicationModelImpl(
  id: json['id'] as String,
  opportunityId: json['opportunityId'] as String,
  startupId: json['startupId'] as String,
  studentId: json['studentId'] as String,
  resumeUrl: json['resumeUrl'] as String,
  screeningAnswers:
      (json['screeningAnswers'] as List<dynamic>?)
          ?.map((e) => ScreeningAnswer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ScreeningAnswer>[],
  status:
      $enumDecodeNullable(_$ApplicationStatusEnumMap, json['status']) ??
      ApplicationStatus.pending,
  appliedAt: const FirestoreTimestampConverter().fromJson(json['appliedAt']),
  updatedAt: const FirestoreTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$ApplicationModelImplToJson(
  _$ApplicationModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'opportunityId': instance.opportunityId,
  'startupId': instance.startupId,
  'studentId': instance.studentId,
  'resumeUrl': instance.resumeUrl,
  'screeningAnswers': instance.screeningAnswers,
  'status': _$ApplicationStatusEnumMap[instance.status]!,
  'appliedAt': const FirestoreTimestampConverter().toJson(instance.appliedAt),
  'updatedAt': const FirestoreTimestampConverter().toJson(instance.updatedAt),
};

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.pending: 'pending',
  ApplicationStatus.reviewed: 'reviewed',
  ApplicationStatus.shortlisted: 'shortlisted',
  ApplicationStatus.rejected: 'rejected',
};
