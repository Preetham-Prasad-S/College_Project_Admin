import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/entities/staff_timestamp.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/entities/working_days.dart';

abstract interface class HomeRepository {
  Stream<Either<AppFailure, CollegeLocation>> currentLocation();
  Future<Either<AppFailure, CollegeLocation>> getCollegeLocation();
  Future<Either<AppFailure, StaffShift>> getStaffShift();
  Future<Either<AppFailure, StaffTimestamp>> getStaffStatus(DateTime dateTime);
  Future<Either<AppFailure, void>> setStaffStatus(
    StaffAttendanceEntry staffEntry,
  );
  Future<Either<AppFailure, CollegeHolidays?>> getHolidayDays(
    DateTime dateTime,
  );
  Future<Either<AppFailure, WorkingDays>> getAttendedDays(DateTime dateTime);
}
