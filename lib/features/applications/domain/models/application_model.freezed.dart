// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ScreeningAnswer _$ScreeningAnswerFromJson(Map<String, dynamic> json) {
  return _ScreeningAnswer.fromJson(json);
}

/// @nodoc
mixin _$ScreeningAnswer {
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;

  /// Serializes this ScreeningAnswer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScreeningAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScreeningAnswerCopyWith<ScreeningAnswer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreeningAnswerCopyWith<$Res> {
  factory $ScreeningAnswerCopyWith(
    ScreeningAnswer value,
    $Res Function(ScreeningAnswer) then,
  ) = _$ScreeningAnswerCopyWithImpl<$Res, ScreeningAnswer>;
  @useResult
  $Res call({String question, String answer});
}

/// @nodoc
class _$ScreeningAnswerCopyWithImpl<$Res, $Val extends ScreeningAnswer>
    implements $ScreeningAnswerCopyWith<$Res> {
  _$ScreeningAnswerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScreeningAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? question = null, Object? answer = null}) {
    return _then(
      _value.copyWith(
            question: null == question
                ? _value.question
                : question // ignore: cast_nullable_to_non_nullable
                      as String,
            answer: null == answer
                ? _value.answer
                : answer // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScreeningAnswerImplCopyWith<$Res>
    implements $ScreeningAnswerCopyWith<$Res> {
  factory _$$ScreeningAnswerImplCopyWith(
    _$ScreeningAnswerImpl value,
    $Res Function(_$ScreeningAnswerImpl) then,
  ) = __$$ScreeningAnswerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String question, String answer});
}

/// @nodoc
class __$$ScreeningAnswerImplCopyWithImpl<$Res>
    extends _$ScreeningAnswerCopyWithImpl<$Res, _$ScreeningAnswerImpl>
    implements _$$ScreeningAnswerImplCopyWith<$Res> {
  __$$ScreeningAnswerImplCopyWithImpl(
    _$ScreeningAnswerImpl _value,
    $Res Function(_$ScreeningAnswerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScreeningAnswer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? question = null, Object? answer = null}) {
    return _then(
      _$ScreeningAnswerImpl(
        question: null == question
            ? _value.question
            : question // ignore: cast_nullable_to_non_nullable
                  as String,
        answer: null == answer
            ? _value.answer
            : answer // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScreeningAnswerImpl implements _ScreeningAnswer {
  const _$ScreeningAnswerImpl({required this.question, required this.answer});

  factory _$ScreeningAnswerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScreeningAnswerImplFromJson(json);

  @override
  final String question;
  @override
  final String answer;

  @override
  String toString() {
    return 'ScreeningAnswer(question: $question, answer: $answer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreeningAnswerImpl &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, question, answer);

  /// Create a copy of ScreeningAnswer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreeningAnswerImplCopyWith<_$ScreeningAnswerImpl> get copyWith =>
      __$$ScreeningAnswerImplCopyWithImpl<_$ScreeningAnswerImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ScreeningAnswerImplToJson(this);
  }
}

abstract class _ScreeningAnswer implements ScreeningAnswer {
  const factory _ScreeningAnswer({
    required final String question,
    required final String answer,
  }) = _$ScreeningAnswerImpl;

  factory _ScreeningAnswer.fromJson(Map<String, dynamic> json) =
      _$ScreeningAnswerImpl.fromJson;

  @override
  String get question;
  @override
  String get answer;

  /// Create a copy of ScreeningAnswer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScreeningAnswerImplCopyWith<_$ScreeningAnswerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) {
  return _ApplicationModel.fromJson(json);
}

/// @nodoc
mixin _$ApplicationModel {
  String get id => throw _privateConstructorUsedError;
  String get opportunityId => throw _privateConstructorUsedError;
  String get startupId => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get resumeUrl => throw _privateConstructorUsedError;
  List<ScreeningAnswer> get screeningAnswers =>
      throw _privateConstructorUsedError;
  ApplicationStatus get status => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get appliedAt => throw _privateConstructorUsedError;
  @FirestoreTimestampConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ApplicationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationModelCopyWith<ApplicationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationModelCopyWith<$Res> {
  factory $ApplicationModelCopyWith(
    ApplicationModel value,
    $Res Function(ApplicationModel) then,
  ) = _$ApplicationModelCopyWithImpl<$Res, ApplicationModel>;
  @useResult
  $Res call({
    String id,
    String opportunityId,
    String startupId,
    String studentId,
    String resumeUrl,
    List<ScreeningAnswer> screeningAnswers,
    ApplicationStatus status,
    @FirestoreTimestampConverter() DateTime appliedAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res, $Val extends ApplicationModel>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? opportunityId = null,
    Object? startupId = null,
    Object? studentId = null,
    Object? resumeUrl = null,
    Object? screeningAnswers = null,
    Object? status = null,
    Object? appliedAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            opportunityId: null == opportunityId
                ? _value.opportunityId
                : opportunityId // ignore: cast_nullable_to_non_nullable
                      as String,
            startupId: null == startupId
                ? _value.startupId
                : startupId // ignore: cast_nullable_to_non_nullable
                      as String,
            studentId: null == studentId
                ? _value.studentId
                : studentId // ignore: cast_nullable_to_non_nullable
                      as String,
            resumeUrl: null == resumeUrl
                ? _value.resumeUrl
                : resumeUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            screeningAnswers: null == screeningAnswers
                ? _value.screeningAnswers
                : screeningAnswers // ignore: cast_nullable_to_non_nullable
                      as List<ScreeningAnswer>,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ApplicationStatus,
            appliedAt: null == appliedAt
                ? _value.appliedAt
                : appliedAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ApplicationModelImplCopyWith<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  factory _$$ApplicationModelImplCopyWith(
    _$ApplicationModelImpl value,
    $Res Function(_$ApplicationModelImpl) then,
  ) = __$$ApplicationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String opportunityId,
    String startupId,
    String studentId,
    String resumeUrl,
    List<ScreeningAnswer> screeningAnswers,
    ApplicationStatus status,
    @FirestoreTimestampConverter() DateTime appliedAt,
    @FirestoreTimestampConverter() DateTime updatedAt,
  });
}

/// @nodoc
class __$$ApplicationModelImplCopyWithImpl<$Res>
    extends _$ApplicationModelCopyWithImpl<$Res, _$ApplicationModelImpl>
    implements _$$ApplicationModelImplCopyWith<$Res> {
  __$$ApplicationModelImplCopyWithImpl(
    _$ApplicationModelImpl _value,
    $Res Function(_$ApplicationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? opportunityId = null,
    Object? startupId = null,
    Object? studentId = null,
    Object? resumeUrl = null,
    Object? screeningAnswers = null,
    Object? status = null,
    Object? appliedAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$ApplicationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        opportunityId: null == opportunityId
            ? _value.opportunityId
            : opportunityId // ignore: cast_nullable_to_non_nullable
                  as String,
        startupId: null == startupId
            ? _value.startupId
            : startupId // ignore: cast_nullable_to_non_nullable
                  as String,
        studentId: null == studentId
            ? _value.studentId
            : studentId // ignore: cast_nullable_to_non_nullable
                  as String,
        resumeUrl: null == resumeUrl
            ? _value.resumeUrl
            : resumeUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        screeningAnswers: null == screeningAnswers
            ? _value._screeningAnswers
            : screeningAnswers // ignore: cast_nullable_to_non_nullable
                  as List<ScreeningAnswer>,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ApplicationStatus,
        appliedAt: null == appliedAt
            ? _value.appliedAt
            : appliedAt // ignore: cast_nullable_to_non_nullable
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
class _$ApplicationModelImpl implements _ApplicationModel {
  const _$ApplicationModelImpl({
    required this.id,
    required this.opportunityId,
    required this.startupId,
    required this.studentId,
    required this.resumeUrl,
    final List<ScreeningAnswer> screeningAnswers = const <ScreeningAnswer>[],
    this.status = ApplicationStatus.pending,
    @FirestoreTimestampConverter() required this.appliedAt,
    @FirestoreTimestampConverter() required this.updatedAt,
  }) : _screeningAnswers = screeningAnswers;

  factory _$ApplicationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationModelImplFromJson(json);

  @override
  final String id;
  @override
  final String opportunityId;
  @override
  final String startupId;
  @override
  final String studentId;
  @override
  final String resumeUrl;
  final List<ScreeningAnswer> _screeningAnswers;
  @override
  @JsonKey()
  List<ScreeningAnswer> get screeningAnswers {
    if (_screeningAnswers is EqualUnmodifiableListView)
      return _screeningAnswers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_screeningAnswers);
  }

  @override
  @JsonKey()
  final ApplicationStatus status;
  @override
  @FirestoreTimestampConverter()
  final DateTime appliedAt;
  @override
  @FirestoreTimestampConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ApplicationModel(id: $id, opportunityId: $opportunityId, startupId: $startupId, studentId: $studentId, resumeUrl: $resumeUrl, screeningAnswers: $screeningAnswers, status: $status, appliedAt: $appliedAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.opportunityId, opportunityId) ||
                other.opportunityId == opportunityId) &&
            (identical(other.startupId, startupId) ||
                other.startupId == startupId) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.resumeUrl, resumeUrl) ||
                other.resumeUrl == resumeUrl) &&
            const DeepCollectionEquality().equals(
              other._screeningAnswers,
              _screeningAnswers,
            ) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    opportunityId,
    startupId,
    studentId,
    resumeUrl,
    const DeepCollectionEquality().hash(_screeningAnswers),
    status,
    appliedAt,
    updatedAt,
  );

  /// Create a copy of ApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationModelImplCopyWith<_$ApplicationModelImpl> get copyWith =>
      __$$ApplicationModelImplCopyWithImpl<_$ApplicationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationModelImplToJson(this);
  }
}

abstract class _ApplicationModel implements ApplicationModel {
  const factory _ApplicationModel({
    required final String id,
    required final String opportunityId,
    required final String startupId,
    required final String studentId,
    required final String resumeUrl,
    final List<ScreeningAnswer> screeningAnswers,
    final ApplicationStatus status,
    @FirestoreTimestampConverter() required final DateTime appliedAt,
    @FirestoreTimestampConverter() required final DateTime updatedAt,
  }) = _$ApplicationModelImpl;

  factory _ApplicationModel.fromJson(Map<String, dynamic> json) =
      _$ApplicationModelImpl.fromJson;

  @override
  String get id;
  @override
  String get opportunityId;
  @override
  String get startupId;
  @override
  String get studentId;
  @override
  String get resumeUrl;
  @override
  List<ScreeningAnswer> get screeningAnswers;
  @override
  ApplicationStatus get status;
  @override
  @FirestoreTimestampConverter()
  DateTime get appliedAt;
  @override
  @FirestoreTimestampConverter()
  DateTime get updatedAt;

  /// Create a copy of ApplicationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationModelImplCopyWith<_$ApplicationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
