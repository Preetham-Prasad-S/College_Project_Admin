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
  StaffHistoryDataModel toHistoryModel({required StaffHistoryDataModel model}) {
    if (type == "clock_in") {
      return StaffHistoryDataModel(
        clockIn: entry,
        clockOut: model.clockOut,
        lateEntry: model.lateEntry,
        lateExit: model.lateExit,
        status: type,
      );
    } else {
      return StaffHistoryDataModel(
        clockIn: model.clockIn,
        clockOut: entry,
        lateEntry: model.lateEntry,
        lateExit: model.lateExit,
        status: type,
      );
    }
  }
}
