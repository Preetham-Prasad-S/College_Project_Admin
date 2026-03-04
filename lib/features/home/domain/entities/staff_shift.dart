import 'package:cloud_firestore/cloud_firestore.dart';

class StaffShift {
  final DateTime start;
  final DateTime end;

  StaffShift({required this.start, required this.end});

  factory StaffShift.fromJson(Map<String, dynamic> json) {
    return StaffShift(
      start: (json["start"] as Timestamp).toDate(),
      end: (json["end"] as Timestamp).toDate(),
    );
  }

  @override
  String toString() {
    return "StaffShift(start : $start, end : $end)";
  }
}
