import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/data/models/staff_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';
import 'package:staff_app/features/home/data/models/working_days_model.dart';

abstract interface class HomeDatasource {
  Future<WorkingDaysModel> getWorkingDays(DateTime dateTime);
  Future<StaffShiftModel> getStaffShift();
  Future<CollegeLocationModel> getCollegeLocation();
  Future<StaffHistoryModel> getStaffHistory(DateTime dateTime);
  Future<void> setStaffHistory(StaffAttendanceEntryModel model);
}
