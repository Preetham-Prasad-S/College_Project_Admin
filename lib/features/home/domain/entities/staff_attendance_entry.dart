import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';

class StaffAttendanceEntry {
  final DateTime entry;
  final String type;
  final bool isLateEntry;
  final bool isLateExit; // "clock_in" | "clock_out"

  StaffAttendanceEntry({
    required this.entry,
    required this.type,
    required this.isLateEntry,
    required this.isLateExit,
  });

  /// Convert event → updated day state
  StaffHistoryDataModel toHistoryModel({
    required StaffHistoryDataModel? existing,
  }) {
    if (type == "clock_in") {
      return StaffHistoryDataModel(
        clockIn: entry,
        clockOut: existing?.clockOut,
        lateEntry: existing?.lateEntry ?? false,
        lateExit: existing?.lateExit ?? false,
        status: "present",
      );
    } else {
      return StaffHistoryDataModel(
        clockIn: existing?.clockIn,
        clockOut: entry,
        lateEntry: existing?.lateEntry ?? false,
        lateExit: existing?.lateExit ?? false,
        status: "present",
      );
    }
  }
}
