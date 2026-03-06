// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:staff_app/features/home/data/models/staff_history_model.dart';

class StaffHistory {
  final DateTime? clockIn;
  final DateTime? clockOut;

  StaffHistory({required this.clockIn, required this.clockOut});

  factory StaffHistory.fromModel(StaffHistoryModel model) {
    return StaffHistory(clockIn: model.clockIn, clockOut: model.clockOut);
  }

  @override
  String toString() => 'StaffHistory(clockIn: $clockIn, clockOut: $clockOut)';
}
