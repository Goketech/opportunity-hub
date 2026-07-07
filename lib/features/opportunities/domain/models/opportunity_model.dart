import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:opportunity_hub/core/firestore/timestamp_converter.dart';

part 'opportunity_model.freezed.dart';
part 'opportunity_model.g.dart';

enum CompensationType {
  @JsonValue('paid')
  paid,
  @JsonValue('stipend')
  stipend,
  @JsonValue('unpaid')
  unpaid,
  @JsonValue('equity')
  equity,
}

@freezed
class OpportunityModel with _$OpportunityModel {
  const factory OpportunityModel({
    required String id,
    required String startupId,
    required String title,
    required String category,
    required String description,
    @Default(<String>[]) List<String> requirements,
    required String duration,
    required CompensationType compensationType,
    @Default(<String>[]) List<String> screeningQuestions,
    @Default(true) bool isOpen,
    @FirestoreTimestampConverter() required DateTime createdAt,
    @FirestoreTimestampConverter() required DateTime updatedAt,
  }) = _OpportunityModel;

  factory OpportunityModel.fromJson(Map<String, dynamic> json) =>
      _$OpportunityModelFromJson(json);
}
