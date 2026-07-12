import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:opportunity_hub/core/firestore/timestamp_converter.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum UserRole {
  @JsonValue('student')
  student,
  @JsonValue('startup_founder')
  startupFounder,
}

enum StartupVerificationMethod {
  @JsonValue('venture_tracking_id')
  ventureTrackingId,
  @JsonValue('approval_token')
  approvalToken,
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required UserRole role,
    required String fullName,
    required String aluEmail,
    required String bio,
    @Default(<String>[]) List<String> skills,
    @Default(<String>[]) List<String> portfolioUrls,
    String? avatarUrl,
    @Default(false) bool isProfileComplete,
    String? startupId,
    StartupVerificationMethod? startupVerificationMethod,
    String? startupVerificationReference,
    @FirestoreTimestampConverter() required DateTime createdAt,
    @FirestoreTimestampConverter() required DateTime updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
