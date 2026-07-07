import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:opportunity_hub/core/firestore/timestamp_converter.dart';

part 'startup_model.freezed.dart';
part 'startup_model.g.dart';

@freezed
class StartupModel with _$StartupModel {
  const factory StartupModel({
    required String id,
    required String name,
    required String logoUrl,
    @Default(false) bool isAluVerified,
    @Default(<String>[]) List<String> founderIds,
    required int teamSize,
    required String description,
    @Default(<String>[]) List<String> categories,
    @Default('active') String status,
    @FirestoreTimestampConverter() required DateTime createdAt,
    @FirestoreTimestampConverter() required DateTime updatedAt,
  }) = _StartupModel;

  factory StartupModel.fromJson(Map<String, dynamic> json) =>
      _$StartupModelFromJson(json);
}
