import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/college_holidays_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_status_model.dart';
import 'package:staff_app/features/home/data/models/staff_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';
import 'package:staff_app/features/home/data/models/working_days_model.dart';

abstract interface class HomeDatasource {
  Future<CollegeHolidaysModel> getHolidayDays(DateTime dateTime);
  Future<WorkingDaysModel> getAttendedDays(DateTime dateTime);
  Future<StaffShiftModel> getStaffShift();
  Future<CollegeLocationModel> getCollegeLocation();
  Future<StaffHistoryModel> getStaffStatus(DateTime dateTime);
  Future<void> setStaffStatus(StaffAttendanceEntryModel model);
  // Future<StaffAttendanceStatusModel> getStaffAttendanceHistory();
}
