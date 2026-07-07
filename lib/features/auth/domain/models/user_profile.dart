import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

enum UserRole {
  @JsonValue('student')
  student,
  @JsonValue('startup_founder')
  startupFounder,
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
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
