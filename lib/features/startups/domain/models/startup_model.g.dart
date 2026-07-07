// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startup_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StartupModelImpl _$$StartupModelImplFromJson(
  Map<String, dynamic> json,
) => _$StartupModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String,
  isAluVerified: json['isAluVerified'] as bool? ?? false,
  founderIds:
      (json['founderIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  teamSize: (json['teamSize'] as num).toInt(),
  description: json['description'] as String,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  status: json['status'] as String? ?? 'active',
  createdAt: const FirestoreTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const FirestoreTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$StartupModelImplToJson(
  _$StartupModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'isAluVerified': instance.isAluVerified,
  'founderIds': instance.founderIds,
  'teamSize': instance.teamSize,
  'description': instance.description,
  'categories': instance.categories,
  'status': instance.status,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const FirestoreTimestampConverter().toJson(instance.updatedAt),
};
