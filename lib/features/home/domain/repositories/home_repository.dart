import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';

abstract interface class HomeRepository {
  Stream<Either<AppFailure, CollegeLocation>> currentLocation();
  Future<Either<AppFailure, CollegeLocation>> getCollegeLocation();
  Future<Either<AppFailure, StaffShift>> getStaffShift();
  Future<Either<AppFailure, StaffStatus>> getStaffStatus();
}
