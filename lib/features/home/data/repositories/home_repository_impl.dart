import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource dataSource;

  HomeRepositoryImpl({required this.dataSource});
  @override
  Stream<Either<AppFailure, CollegeLocation>> currentLocation() {
    // TODO: implement currentLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, CollegeLocation>> getCollegeLocation() {
    // TODO: implement getCollegeLocation
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, StaffShift>> getStaffShift() {
    // TODO: implement getStaffShift
    throw UnimplementedError();
  }

  @override
  Future<Either<AppFailure, StaffStatus>> getStaffStatus() {
    // TODO: implement getStaffStatus
    throw UnimplementedError();
  }
}
