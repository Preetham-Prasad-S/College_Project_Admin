import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/entities/staff_history.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';

abstract interface class HomeRepository {
  Stream<Either<AppFailure, CollegeLocation>> currentLocation();
  Future<Either<AppFailure, CollegeLocation>> getCollegeLocation();
  Future<Either<AppFailure, StaffShift>> getStaffShift();
  Future<Either<AppFailure, StaffHistory>> getStaffHistory(DateTime dateTime);
  Future<Either<AppFailure, void>> setStaffHistory(
    StaffAttendanceEntry staffEntry,
  );
}
