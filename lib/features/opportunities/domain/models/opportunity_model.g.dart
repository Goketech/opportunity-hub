// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opportunity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OpportunityModelImpl _$$OpportunityModelImplFromJson(
  Map<String, dynamic> json,
) => _$OpportunityModelImpl(
  id: json['id'] as String,
  startupId: json['startupId'] as String,
  title: json['title'] as String,
  category: json['category'] as String,
  description: json['description'] as String,
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  duration: json['duration'] as String,
  compensationType: $enumDecode(
    _$CompensationTypeEnumMap,
    json['compensationType'],
  ),
  screeningQuestions:
      (json['screeningQuestions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  isOpen: json['isOpen'] as bool? ?? true,
  createdAt: const FirestoreTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const FirestoreTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$OpportunityModelImplToJson(
  _$OpportunityModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'startupId': instance.startupId,
  'title': instance.title,
  'category': instance.category,
  'description': instance.description,
  'requirements': instance.requirements,
  'duration': instance.duration,
  'compensationType': _$CompensationTypeEnumMap[instance.compensationType]!,
  'screeningQuestions': instance.screeningQuestions,
  'isOpen': instance.isOpen,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const FirestoreTimestampConverter().toJson(instance.updatedAt),
};

const _$CompensationTypeEnumMap = {
  CompensationType.paid: 'paid',
  CompensationType.stipend: 'stipend',
  CompensationType.unpaid: 'unpaid',
  CompensationType.equity: 'equity',
};
