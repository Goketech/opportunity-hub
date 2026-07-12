// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get aluEmail => throw _privateConstructorUsedError;
  String get bio => throw _privateConstructorUsedError;
  List<String> get skills => throw _privateConstructorUsedError;
  List<String> get portfolioUrls => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  bool get isProfileComplete => throw _privateConstructorUsedError;
  String? get startupId => throw _privateConstructorUsedError;
  StartupVerificationMethod? get startupVerificationMethod =>
      throw _privateConstructorUsedError;
  String? get startupVerificationReference =>
      throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    UserRole role,
    String fullName,
    String aluEmail,
    String bio,
    List<String> skills,
    List<String> portfolioUrls,
    String? avatarUrl,
    bool isProfileComplete,
    String? startupId,
    StartupVerificationMethod? startupVerificationMethod,
    String? startupVerificationReference,
    @FirestoreTimestampConverter() DateTime createdAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? fullName = null,
    Object? aluEmail = null,
    Object? bio = null,
    Object? skills = null,
    Object? portfolioUrls = null,
    Object? avatarUrl = freezed,
    Object? isProfileComplete = null,
    Object? startupId = freezed,
    Object? startupVerificationMethod = freezed,
    Object? startupVerificationReference = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as UserRole,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            aluEmail: null == aluEmail
                ? _value.aluEmail
                : aluEmail // ignore: cast_nullable_to_non_nullable
                      as String,
            bio: null == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String,
            skills: null == skills
                ? _value.skills
                : skills // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            portfolioUrls: null == portfolioUrls
                ? _value.portfolioUrls
                : portfolioUrls // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isProfileComplete: null == isProfileComplete
                ? _value.isProfileComplete
                : isProfileComplete // ignore: cast_nullable_to_non_nullable
                      as bool,
            startupId: freezed == startupId
                ? _value.startupId
                : startupId // ignore: cast_nullable_to_non_nullable
                      as String?,
            startupVerificationMethod: freezed == startupVerificationMethod
                ? _value.startupVerificationMethod
                : startupVerificationMethod // ignore: cast_nullable_to_non_nullable
                      as StartupVerificationMethod?,
            startupVerificationReference:
                freezed == startupVerificationReference
                ? _value.startupVerificationReference
                : startupVerificationReference // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    UserRole role,
    String fullName,
    String aluEmail,
    String bio,
    List<String> skills,
    List<String> portfolioUrls,
    String? avatarUrl,
    bool isProfileComplete,
    String? startupId,
    StartupVerificationMethod? startupVerificationMethod,
    String? startupVerificationReference,
    @FirestoreTimestampConverter() DateTime createdAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = null,
    Object? fullName = null,
    Object? aluEmail = null,
    Object? bio = null,
    Object? skills = null,
    Object? portfolioUrls = null,
    Object? avatarUrl = freezed,
    Object? isProfileComplete = null,
    Object? startupId = freezed,
    Object? startupVerificationMethod = freezed,
    Object? startupVerificationReference = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as UserRole,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        aluEmail: null == aluEmail
            ? _value.aluEmail
            : aluEmail // ignore: cast_nullable_to_non_nullable
                  as String,
        bio: null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
        skills: null == skills
            ? _value._skills
            : skills // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        portfolioUrls: null == portfolioUrls
            ? _value._portfolioUrls
            : portfolioUrls // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isProfileComplete: null == isProfileComplete
            ? _value.isProfileComplete
            : isProfileComplete // ignore: cast_nullable_to_non_nullable
                  as bool,
        startupId: freezed == startupId
            ? _value.startupId
            : startupId // ignore: cast_nullable_to_non_nullable
                  as String?,
        startupVerificationMethod: freezed == startupVerificationMethod
            ? _value.startupVerificationMethod
            : startupVerificationMethod // ignore: cast_nullable_to_non_nullable
                  as StartupVerificationMethod?,
        startupVerificationReference: freezed == startupVerificationReference
            ? _value.startupVerificationReference
            : startupVerificationReference // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    required this.role,
    required this.fullName,
    required this.aluEmail,
    required this.bio,
    final List<String> skills = const <String>[],
    final List<String> portfolioUrls = const <String>[],
    this.avatarUrl,
    this.isProfileComplete = false,
    this.startupId,
    this.startupVerificationMethod,
    this.startupVerificationReference,
    @FirestoreTimestampConverter() required this.createdAt,
    @FirestoreTimestampConverter() required this.updatedAt,
  }) : _skills = skills,
       _portfolioUrls = portfolioUrls;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String id;
  @override
  final UserRole role;
  @override
  final String fullName;
  @override
  final String aluEmail;
  @override
  final String bio;
  final List<String> _skills;
  @override
  @JsonKey()
  List<String> get skills {
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_skills);
  }

  final List<String> _portfolioUrls;
  @override
  @JsonKey()
  List<String> get portfolioUrls {
    if (_portfolioUrls is EqualUnmodifiableListView) return _portfolioUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_portfolioUrls);
  }

  @override
  final String? avatarUrl;
  @override
  @JsonKey()
  final bool isProfileComplete;
  @override
  final String? startupId;
  @override
  final StartupVerificationMethod? startupVerificationMethod;
  @override
  final String? startupVerificationReference;
  @override
  @FirestoreTimestampConverter()
  final DateTime createdAt;
  @override
  @FirestoreTimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, role: $role, fullName: $fullName, aluEmail: $aluEmail, bio: $bio, skills: $skills, portfolioUrls: $portfolioUrls, avatarUrl: $avatarUrl, isProfileComplete: $isProfileComplete, startupId: $startupId, startupVerificationMethod: $startupVerificationMethod, startupVerificationReference: $startupVerificationReference, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.aluEmail, aluEmail) ||
                other.aluEmail == aluEmail) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality().equals(
              other._portfolioUrls,
              _portfolioUrls,
            ) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isProfileComplete, isProfileComplete) ||
                other.isProfileComplete == isProfileComplete) &&
            (identical(other.startupId, startupId) ||
                other.startupId == startupId) &&
            (identical(
                  other.startupVerificationMethod,
                  startupVerificationMethod,
                ) ||
                other.startupVerificationMethod == startupVerificationMethod) &&
            (identical(
                  other.startupVerificationReference,
                  startupVerificationReference,
                ) ||
                other.startupVerificationReference ==
                    startupVerificationReference) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    role,
    fullName,
    aluEmail,
    bio,
    const DeepCollectionEquality().hash(_skills),
    const DeepCollectionEquality().hash(_portfolioUrls),
    avatarUrl,
    isProfileComplete,
    startupId,
    startupVerificationMethod,
    startupVerificationReference,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    required final UserRole role,
    required final String fullName,
    required final String aluEmail,
    required final String bio,
    final List<String> skills,
    final List<String> portfolioUrls,
    final String? avatarUrl,
    final bool isProfileComplete,
    final String? startupId,
    final StartupVerificationMethod? startupVerificationMethod,
    final String? startupVerificationReference,
    @FirestoreTimestampConverter() required final DateTime createdAt,
    @FirestoreTimestampConverter() required final DateTime updatedAt,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get id;
  @override
  UserRole get role;
  @override
  String get fullName;
  @override
  String get aluEmail;
  @override
  String get bio;
  @override
  List<String> get skills;
  @override
  List<String> get portfolioUrls;
  @override
  String? get avatarUrl;
  @override
  bool get isProfileComplete;
  @override
  String? get startupId;
  @override
  StartupVerificationMethod? get startupVerificationMethod;
  @override
  String? get startupVerificationReference;
  @override
  @FirestoreTimestampConverter()
  DateTime get createdAt;
  @override
  @FirestoreTimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
