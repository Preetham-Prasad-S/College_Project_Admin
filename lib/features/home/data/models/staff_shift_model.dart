import 'package:cloud_firestore/cloud_firestore.dart';

class StaffShiftModel {
  final DateTime start;
  final DateTime end;

  StaffShiftModel({required this.start, required this.end});

  factory StaffShiftModel.fromJson(Map<String, dynamic> json) {
    return StaffShiftModel(
      start: DateTime.fromMillisecondsSinceEpoch(json["start"] as int),
      end: DateTime.fromMillisecondsSinceEpoch(json["end"] as int),
    );
  }

  @override
  String toString() {
    return "StaffShiftModel(start : $start, end : $end)";
  }
}
