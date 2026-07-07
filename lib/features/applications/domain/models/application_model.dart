import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:opportunity_hub/core/firestore/timestamp_converter.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

enum ApplicationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('reviewed')
  reviewed,
  @JsonValue('shortlisted')
  shortlisted,
  @JsonValue('rejected')
  rejected,
}

@freezed
class ScreeningAnswer with _$ScreeningAnswer {
  const factory ScreeningAnswer({
    required String question,
    required String answer,
  }) = _ScreeningAnswer;

  factory ScreeningAnswer.fromJson(Map<String, dynamic> json) =>
      _$ScreeningAnswerFromJson(json);
}

@freezed
class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    required String id,
    required String opportunityId,
    required String startupId,
    required String studentId,
    required String resumeUrl,
    @Default(<ScreeningAnswer>[]) List<ScreeningAnswer> screeningAnswers,
    @Default(ApplicationStatus.pending) ApplicationStatus status,
    @FirestoreTimestampConverter() required DateTime appliedAt,
    @FirestoreTimestampConverter() required DateTime updatedAt,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationModelFromJson(json);
}
