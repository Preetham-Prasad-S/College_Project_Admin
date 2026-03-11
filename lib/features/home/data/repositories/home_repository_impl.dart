import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/services/service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/entities/staff_history.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource dataSource;
  final LocationService locationService;

  HomeRepositoryImpl({required this.dataSource, required this.locationService});
  @override
  Stream<Either<AppFailure, CollegeLocation>> currentLocation() async* {
    try {
      final locationStream = locationService.getCurrentLocation();

      yield* locationStream.map((position) {
        return right(CollegeLocation.fromService(position));
      });
    } on DeviceExcepiton catch (e) {
      yield left(AppFailure(message: e.message));
    } catch (e) {
      yield left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, CollegeLocation>> getCollegeLocation() async {
    try {
      final collegeLocation = await dataSource.getCollegeLocation();

      return right(CollegeLocation.fromModel(collegeLocation));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffShift>> getStaffShift() async {
    try {
      final staffShit = await dataSource.getStaffShift();

      return right(StaffShift.fromeModel(staffShit));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffStatus>> getStaffStatus() async {
    try {
      final staffStatus = await dataSource.getStaffStatus();

      return right(StaffStatus.fromModel(staffStatus));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffHistory>> getStaffHistory(
    DateTime dateTime,
  ) async {
    try {
      final staffHistory = await dataSource.getStaffHistory(dateTime);

      return right(StaffHistory.fromModel(staffHistory));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> setStaffHistory(
    StaffAttendanceEntry staffEntry,
  ) async {
    try {
      await dataSource.setStaffHistory(staffEntry.toModel());

      return right(null);
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }
}
