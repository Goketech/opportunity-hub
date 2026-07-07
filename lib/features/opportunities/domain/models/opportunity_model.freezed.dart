// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opportunity_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OpportunityModel _$OpportunityModelFromJson(Map<String, dynamic> json) {
  return _OpportunityModel.fromJson(json);
}

/// @nodoc
mixin _$OpportunityModel {
  String get id => throw _privateConstructorUsedError;
  String get startupId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get requirements => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  CompensationType get compensationType => throw _privateConstructorUsedError;
  List<String> get screeningQuestions => throw _privateConstructorUsedError;
  bool get isOpen => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OpportunityModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OpportunityModelCopyWith<OpportunityModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpportunityModelCopyWith<$Res> {
  factory $OpportunityModelCopyWith(
    OpportunityModel value,
    $Res Function(OpportunityModel) then,
  ) = _$OpportunityModelCopyWithImpl<$Res, OpportunityModel>;
  @useResult
  $Res call({
    String id,
    String startupId,
    String title,
    String category,
    String description,
    List<String> requirements,
    String duration,
    CompensationType compensationType,
    List<String> screeningQuestions,
    bool isOpen,
    @FirestoreTimestampConverter() DateTime createdAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$OpportunityModelCopyWithImpl<$Res, $Val extends OpportunityModel>
    implements $OpportunityModelCopyWith<$Res> {
  _$OpportunityModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startupId = null,
    Object? title = null,
    Object? category = null,
    Object? description = null,
    Object? requirements = null,
    Object? duration = null,
    Object? compensationType = null,
    Object? screeningQuestions = null,
    Object? isOpen = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            startupId: null == startupId
                ? _value.startupId
                : startupId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            requirements: null == requirements
                ? _value.requirements
                : requirements // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as String,
            compensationType: null == compensationType
                ? _value.compensationType
                : compensationType // ignore: cast_nullable_to_non_nullable
                      as CompensationType,
            screeningQuestions: null == screeningQuestions
                ? _value.screeningQuestions
                : screeningQuestions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isOpen: null == isOpen
                ? _value.isOpen
                : isOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$OpportunityModelImplCopyWith<$Res>
    implements $OpportunityModelCopyWith<$Res> {
  factory _$$OpportunityModelImplCopyWith(
    _$OpportunityModelImpl value,
    $Res Function(_$OpportunityModelImpl) then,
  ) = __$$OpportunityModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String startupId,
    String title,
    String category,
    String description,
    List<String> requirements,
    String duration,
    CompensationType compensationType,
    List<String> screeningQuestions,
    bool isOpen,
    @FirestoreTimestampConverter() DateTime createdAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$OpportunityModelImplCopyWithImpl<$Res>
    extends _$OpportunityModelCopyWithImpl<$Res, _$OpportunityModelImpl>
    implements _$$OpportunityModelImplCopyWith<$Res> {
  __$$OpportunityModelImplCopyWithImpl(
    _$OpportunityModelImpl _value,
    $Res Function(_$OpportunityModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startupId = null,
    Object? title = null,
    Object? category = null,
    Object? description = null,
    Object? requirements = null,
    Object? duration = null,
    Object? compensationType = null,
    Object? screeningQuestions = null,
    Object? isOpen = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$OpportunityModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        startupId: null == startupId
            ? _value.startupId
            : startupId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        requirements: null == requirements
            ? _value._requirements
            : requirements // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as String,
        compensationType: null == compensationType
            ? _value.compensationType
            : compensationType // ignore: cast_nullable_to_non_nullable
                  as CompensationType,
        screeningQuestions: null == screeningQuestions
            ? _value._screeningQuestions
            : screeningQuestions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isOpen: null == isOpen
            ? _value.isOpen
            : isOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$OpportunityModelImpl implements _OpportunityModel {
  const _$OpportunityModelImpl({
    required this.id,
    required this.startupId,
    required this.title,
    required this.category,
    required this.description,
    final List<String> requirements = const <String>[],
    required this.duration,
    required this.compensationType,
    final List<String> screeningQuestions = const <String>[],
    this.isOpen = true,
    @FirestoreTimestampConverter() required this.createdAt,
    @FirestoreTimestampConverter() required this.updatedAt,
  }) : _requirements = requirements,
       _screeningQuestions = screeningQuestions;

  factory _$OpportunityModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpportunityModelImplFromJson(json);

  @override
  final String id;
  @override
  final String startupId;
  @override
  final String title;
  @override
  final String category;
  @override
  final String description;
  final List<String> _requirements;
  @override
  @JsonKey()
  List<String> get requirements {
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requirements);
  }

  @override
  final String duration;
  @override
  final CompensationType compensationType;
  final List<String> _screeningQuestions;
  @override
  @JsonKey()
  List<String> get screeningQuestions {
    if (_screeningQuestions is EqualUnmodifiableListView)
      return _screeningQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screeningQuestions);
  }

  @override
  @JsonKey()
  final bool isOpen;
  @override
  @FirestoreTimestampConverter()
  final DateTime createdAt;
  @override
  @FirestoreTimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'OpportunityModel(id: $id, startupId: $startupId, title: $title, category: $category, description: $description, requirements: $requirements, duration: $duration, compensationType: $compensationType, screeningQuestions: $screeningQuestions, isOpen: $isOpen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpportunityModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startupId, startupId) ||
                other.startupId == startupId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._requirements,
              _requirements,
            ) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.compensationType, compensationType) ||
                other.compensationType == compensationType) &&
            const DeepCollectionEquality().equals(
              other._screeningQuestions,
              _screeningQuestions,
            ) &&
            (identical(other.isOpen, isOpen) || other.isOpen == isOpen) &&
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
    startupId,
    title,
    category,
    description,
    const DeepCollectionEquality().hash(_requirements),
    duration,
    compensationType,
    const DeepCollectionEquality().hash(_screeningQuestions),
    isOpen,
    createdAt,
    updatedAt,
  );

  /// Create a copy of OpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OpportunityModelImplCopyWith<_$OpportunityModelImpl> get copyWith =>
      __$$OpportunityModelImplCopyWithImpl<_$OpportunityModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$OpportunityModelImplToJson(this);
  }
}

abstract class _OpportunityModel implements OpportunityModel {
  const factory _OpportunityModel({
    required final String id,
    required final String startupId,
    required final String title,
    required final String category,
    required final String description,
    final List<String> requirements,
    required final String duration,
    required final CompensationType compensationType,
    final List<String> screeningQuestions,
    final bool isOpen,
    @FirestoreTimestampConverter() required final DateTime createdAt,
    @FirestoreTimestampConverter() required final DateTime updatedAt,
  }) = _$OpportunityModelImpl;

  factory _OpportunityModel.fromJson(Map<String, dynamic> json) =
      _$OpportunityModelImpl.fromJson;

  @override
  String get id;
  @override
  String get startupId;
  @override
  String get title;
  @override
  String get category;
  @override
  String get description;
  @override
  List<String> get requirements;
  @override
  String get duration;
  @override
  CompensationType get compensationType;
  @override
  List<String> get screeningQuestions;
  @override
  bool get isOpen;
  @override
  @FirestoreTimestampConverter()
  DateTime get createdAt;
  @override
  @FirestoreTimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of OpportunityModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OpportunityModelImplCopyWith<_$OpportunityModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
