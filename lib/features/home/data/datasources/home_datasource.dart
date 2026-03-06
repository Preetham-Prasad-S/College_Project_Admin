import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/staff_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_status_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';

abstract interface class HomeDatasource {
  Future<StaffShiftModel> getStaffShift();
  Future<StaffStatusModel> getStaffStatus();
  Future<CollegeLocationModel> getCollegeLocation();
  Future<StaffHistoryModel> getStaffHistory(DateTime dateTime);
}
