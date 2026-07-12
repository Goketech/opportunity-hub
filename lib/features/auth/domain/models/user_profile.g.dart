// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(
  Map<String, dynamic> json,
) => _$UserProfileImpl(
  id: json['id'] as String,
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  fullName: json['fullName'] as String,
  aluEmail: json['aluEmail'] as String,
  bio: json['bio'] as String,
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  portfolioUrls:
      (json['portfolioUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  avatarUrl: json['avatarUrl'] as String?,
  isProfileComplete: json['isProfileComplete'] as bool? ?? false,
  startupId: json['startupId'] as String?,
  startupVerificationMethod: $enumDecodeNullable(
    _$StartupVerificationMethodEnumMap,
    json['startupVerificationMethod'],
  ),
  startupVerificationReference: json['startupVerificationReference'] as String?,
  createdAt: const FirestoreTimestampConverter().fromJson(json['createdAt']),
  updatedAt: const FirestoreTimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$$UserProfileImplToJson(
  _$UserProfileImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'role': _$UserRoleEnumMap[instance.role]!,
  'fullName': instance.fullName,
  'aluEmail': instance.aluEmail,
  'bio': instance.bio,
  'skills': instance.skills,
  'portfolioUrls': instance.portfolioUrls,
  'avatarUrl': instance.avatarUrl,
  'isProfileComplete': instance.isProfileComplete,
  'startupId': instance.startupId,
  'startupVerificationMethod':
      _$StartupVerificationMethodEnumMap[instance.startupVerificationMethod],
  'startupVerificationReference': instance.startupVerificationReference,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const FirestoreTimestampConverter().toJson(instance.updatedAt),
};

const _$UserRoleEnumMap = {
  UserRole.student: 'student',
  UserRole.startupFounder: 'startup_founder',
};

const _$StartupVerificationMethodEnumMap = {
  StartupVerificationMethod.ventureTrackingId: 'venture_tracking_id',
  StartupVerificationMethod.approvalToken: 'approval_token',
};
