import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';

class StaffAttendanceEntry {
  final DateTime entry;
  final String type;
  final bool isLate;

  StaffAttendanceEntry({
    required this.entry,
    required this.type,
    required this.isLate,
  });

  StaffHistoryDataModel toHistoryModel(StaffHistoryDataModel? model) {
    return type == "clock_in"
        ? StaffHistoryDataModel(
            clockIn: entry,
            clockOut: model?.clockOut,
            lateEntry: isLate,
            lateExit: model?.lateExit ?? false,
            status: isLate ? "Late" : "Present",
          )
        : StaffHistoryDataModel(
            clockIn: model?.clockIn,
            clockOut: entry,
            lateEntry: model?.lateEntry ?? false,
            lateExit: isLate,
            status: isLate ? "Late" : "Present",
          );
  }
}
