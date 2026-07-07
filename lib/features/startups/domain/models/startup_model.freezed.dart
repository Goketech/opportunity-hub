// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'startup_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StartupModel _$StartupModelFromJson(Map<String, dynamic> json) {
  return _StartupModel.fromJson(json);
}

/// @nodoc
mixin _$StartupModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get logoUrl => throw _privateConstructorUsedError;
  bool get isAluVerified => throw _privateConstructorUsedError;
  List<String> get founderIds => throw _privateConstructorUsedError;
  int get teamSize => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this StartupModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StartupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StartupModelCopyWith<StartupModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartupModelCopyWith<$Res> {
  factory $StartupModelCopyWith(
    StartupModel value,
    $Res Function(StartupModel) then,
  ) = _$StartupModelCopyWithImpl<$Res, StartupModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String logoUrl,
    bool isAluVerified,
    List<String> founderIds,
    int teamSize,
    String description,
    List<String> categories,
    String status,
    @FirestoreTimestampConverter() DateTime createdAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$StartupModelCopyWithImpl<$Res, $Val extends StartupModel>
    implements $StartupModelCopyWith<$Res> {
  _$StartupModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StartupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logoUrl = null,
    Object? isAluVerified = null,
    Object? founderIds = null,
    Object? teamSize = null,
    Object? description = null,
    Object? categories = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            logoUrl: null == logoUrl
                ? _value.logoUrl
                : logoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isAluVerified: null == isAluVerified
                ? _value.isAluVerified
                : isAluVerified // ignore: cast_nullable_to_non_nullable
                      as bool,
            founderIds: null == founderIds
                ? _value.founderIds
                : founderIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            teamSize: null == teamSize
                ? _value.teamSize
                : teamSize // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$StartupModelImplCopyWith<$Res>
    implements $StartupModelCopyWith<$Res> {
  factory _$$StartupModelImplCopyWith(
    _$StartupModelImpl value,
    $Res Function(_$StartupModelImpl) then,
  ) = __$$StartupModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String logoUrl,
    bool isAluVerified,
    List<String> founderIds,
    int teamSize,
    String description,
    List<String> categories,
    String status,
    @FirestoreTimestampConverter() DateTime createdAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$StartupModelImplCopyWithImpl<$Res>
    extends _$StartupModelCopyWithImpl<$Res, _$StartupModelImpl>
    implements _$$StartupModelImplCopyWith<$Res> {
  __$$StartupModelImplCopyWithImpl(
    _$StartupModelImpl _value,
    $Res Function(_$StartupModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StartupModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? logoUrl = null,
    Object? isAluVerified = null,
    Object? founderIds = null,
    Object? teamSize = null,
    Object? description = null,
    Object? categories = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$StartupModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        logoUrl: null == logoUrl
            ? _value.logoUrl
            : logoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isAluVerified: null == isAluVerified
            ? _value.isAluVerified
            : isAluVerified // ignore: cast_nullable_to_non_nullable
                  as bool,
        founderIds: null == founderIds
            ? _value._founderIds
            : founderIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        teamSize: null == teamSize
            ? _value.teamSize
            : teamSize // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$StartupModelImpl implements _StartupModel {
  const _$StartupModelImpl({
    required this.id,
    required this.name,
    required this.logoUrl,
    this.isAluVerified = false,
    final List<String> founderIds = const <String>[],
    required this.teamSize,
    required this.description,
    final List<String> categories = const <String>[],
    this.status = 'active',
    @FirestoreTimestampConverter() required this.createdAt,
    @FirestoreTimestampConverter() required this.updatedAt,
  }) : _founderIds = founderIds,
       _categories = categories;

  factory _$StartupModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StartupModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String logoUrl;
  @override
  @JsonKey()
  final bool isAluVerified;
  final List<String> _founderIds;
  @override
  @JsonKey()
  List<String> get founderIds {
    if (_founderIds is EqualUnmodifiableListView) return _founderIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_founderIds);
  }

  @override
  final int teamSize;
  @override
  final String description;
  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final String status;
  @override
  @FirestoreTimestampConverter()
  final DateTime createdAt;
  @override
  @FirestoreTimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'StartupModel(id: $id, name: $name, logoUrl: $logoUrl, isAluVerified: $isAluVerified, founderIds: $founderIds, teamSize: $teamSize, description: $description, categories: $categories, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartupModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.isAluVerified, isAluVerified) ||
                other.isAluVerified == isAluVerified) &&
            const DeepCollectionEquality().equals(
              other._founderIds,
              _founderIds,
            ) &&
            (identical(other.teamSize, teamSize) ||
                other.teamSize == teamSize) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.status, status) || other.status == status) &&
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
    name,
    logoUrl,
    isAluVerified,
    const DeepCollectionEquality().hash(_founderIds),
    teamSize,
    description,
    const DeepCollectionEquality().hash(_categories),
    status,
    createdAt,
    updatedAt,
  );

  /// Create a copy of StartupModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StartupModelImplCopyWith<_$StartupModelImpl> get copyWith =>
      __$$StartupModelImplCopyWithImpl<_$StartupModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StartupModelImplToJson(this);
  }
}

abstract class _StartupModel implements StartupModel {
  const factory _StartupModel({
    required final String id,
    required final String name,
    required final String logoUrl,
    final bool isAluVerified,
    final List<String> founderIds,
    required final int teamSize,
    required final String description,
    final List<String> categories,
    final String status,
    @FirestoreTimestampConverter() required final DateTime createdAt,
    @FirestoreTimestampConverter() required final DateTime updatedAt,
  }) = _$StartupModelImpl;

  factory _StartupModel.fromJson(Map<String, dynamic> json) =
      _$StartupModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get logoUrl;
  @override
  bool get isAluVerified;
  @override
  List<String> get founderIds;
  @override
  int get teamSize;
  @override
  String get description;
  @override
  List<String> get categories;
  @override
  String get status;
  @override
  @FirestoreTimestampConverter()
  DateTime get createdAt;
  @override
  @FirestoreTimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of StartupModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StartupModelImplCopyWith<_$StartupModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
