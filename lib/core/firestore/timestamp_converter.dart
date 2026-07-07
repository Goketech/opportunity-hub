import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class FirestoreTimestampConverter implements JsonConverter<DateTime, Object?> {
  const FirestoreTimestampConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json == null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    }

    if (json is Timestamp) {
      return json.toDate().toUtc();
    }

    if (json is DateTime) {
      return json.toUtc();
    }

    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json, isUtc: true);
    }

    if (json is String) {
      return DateTime.parse(json).toUtc();
    }

    throw FormatException('Unsupported timestamp payload: ${json.runtimeType}');
  }

  @override
  Object toJson(DateTime object) {
    return Timestamp.fromDate(object.toUtc());
  }
}
