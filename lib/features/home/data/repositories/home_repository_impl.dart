import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/services/service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/staff_monthly_history_model.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';

import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/entities/staff_timestamp.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';

import 'package:staff_app/features/home/domain/entities/working_days.dart';
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
      final staffShift = await dataSource.getStaffShift();

      return right(StaffShift.fromModel(staffShift));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffTimestamp>> getStaffStatus(
    DateTime dateTime,
  ) async {
    try {
      final staffHistory = await dataSource.getCurrentMonthHistory(dateTime);

      final data = staffHistory.historyData[dateTime.day];

      if (data == null) {
        return right(StaffTimestamp(clockIn: null, clockOut: null));
      }

      return right(StaffTimestamp.fromModel(data));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } on DataException catch (e) {
      return right(StaffTimestamp(clockIn: null, clockOut: null));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> setStaffStatus(
    StaffAttendanceEntry staffEntry,
  ) async {
    try {
      final now = staffEntry.entry;

      // 1. Get existing month data
      final monthlyHistory = await dataSource.getCurrentMonthHistory(now);

      // 2. Get today's data (if exists)
      final existing = monthlyHistory.historyData[now.day];

      // 3. Convert event → updated state
      final updatedDay = staffEntry.toHistoryModel(
        model: monthlyHistory.historyData[staffEntry.entryd],
      );

      // 4. Update only this day
      await dataSource.setCurrentMonthHistory(
        year: now.year,
        month: now.month,
        model: StaffMonthlyHistoryModel(historyData: {now.day: updatedDay}),
      );

      return right(null);
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, CollegeHolidays>> getHolidayDays(
    DateTime dateTime,
  ) async {
    try {
      final holidayDays = await dataSource.getHolidayDays(dateTime);

      return right(CollegeHolidays.fromModel(holidayDays));
    } on ServerException catch (e) {
      return left(AppFailure(message: "$e -> Repository"));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, WorkingDays>> getAttendedDays(
    DateTime dateTime,
  ) async {
    try {
      final monthHistory = await dataSource.getCurrentMonthHistory(dateTime);

      return right(WorkingDays(workingDays: monthHistory.historyData.length));
    } on ServerException catch (e) {
      return left(AppFailure(message: e.message));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }
}
