import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';

class StaffAttendanceEntry {
  final DateTime entry;
  final String type;

  StaffAttendanceEntry({required this.entry, required this.type});

  StaffAttendanceEntryModel toModel() {
    return StaffAttendanceEntryModel(entry: entry, type: type);
  }
}
