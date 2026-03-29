import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/college_holidays_model.dart';
import 'package:staff_app/features/home/data/models/staff_monthly_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';

abstract interface class HomeDatasource {
  Future<CollegeHolidaysModel> getHolidayDays(DateTime dateTime);
  Future<StaffShiftModel> getStaffShift();
  Future<CollegeLocationModel> getCollegeLocation();
  Future<StaffMonthlyHistoryModel?> getCurrentMonthHistory(
    DateTime currentDateTime,
  );
  Future<void> setCurrentMonthHistory({
    required int year,
    required int month,
    required StaffMonthlyHistoryModel model,
  });
}
