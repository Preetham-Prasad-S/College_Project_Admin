import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/services/service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';
import 'package:staff_app/features/home/data/models/staff_monthly_history_model.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';

import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/entities/staff_timestamp.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';

import 'package:staff_app/features/home/domain/entities/working_days.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _datasource;
  final LocationService _locationService;

  HomeRepositoryImpl({
    required HomeDatasource datasource,
    required LocationService locationService,
  }) : _datasource = datasource,
       _locationService = locationService;
  @override
  Stream<Either<AppFailure, CollegeLocation>> currentLocation() async* {
    try {
      final locationStream = _locationService.getCurrentLocation();

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
      final collegeLocation = await _datasource.getCollegeLocation();

      return right(CollegeLocation.fromModel(collegeLocation));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffShift>> getStaffShift() async {
    try {
      final staffShift = await _datasource.getStaffShift();

      return right(StaffShift.fromModel(staffShift));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffTimestamp>> getStaffStatus(
    DateTime dateTime,
  ) async {
    try {
      final staffHistory = await _datasource.getCurrentMonthHistory(dateTime);

      if (staffHistory == null) {
        return right(StaffTimestamp(clockIn: null, clockOut: null));
      }

      final data = staffHistory.historyData[dateTime.day];

      if (data == null) {
        return right(StaffTimestamp(clockIn: null, clockOut: null));
      }

      return right(StaffTimestamp.fromModel(data));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> setStaffStatus(
    StaffAttendanceEntry staffEntry,
  ) async {
    try {
      StaffHistoryDataModel? currentDateStaffStatus;
      final staffStatus = await _datasource.getCurrentMonthHistory(
        staffEntry.entry,
      );

      if (staffStatus != null) {
        currentDateStaffStatus = staffStatus.historyData[staffEntry.entry.day];
      }

      await _datasource.setCurrentMonthHistory(
        month: staffEntry.entry.month,
        year: staffEntry.entry.year,
        model: StaffMonthlyHistoryModel(
          historyData: {
            staffEntry.entry.day: staffEntry.toHistoryModel(
              currentDateStaffStatus,
            ),
          },
        ),
      );

      return right(null);
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, CollegeHolidays?>> getHolidayDays(
    DateTime dateTime,
  ) async {
    try {
      final holidayDays = await _datasource.getHolidayDays(dateTime);

      if (holidayDays != null) {
        return right(CollegeHolidays.fromModel(holidayDays));
      }
      return right(null);
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, WorkingDays>> getAttendedDays(
    DateTime dateTime,
  ) async {
    int workingDays = 0;

    try {
      final monthHistory = await _datasource.getCurrentMonthHistory(dateTime);

      if (monthHistory != null) {
        workingDays = monthHistory.historyData.length;
      }

      return right(WorkingDays(workingDays: workingDays));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, WorkingDays>> getLateDays(DateTime dateTime) async {
    int lateDays = 0;

    try {
      final monthHistory = await _datasource.getCurrentMonthHistory(dateTime);

      if (monthHistory != null) {
        monthHistory.historyData.mapValue((value) {
          if (value.status == "Late") {
            lateDays++;
          }
        });
      }

      return right(WorkingDays(workingDays: lateDays));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }
}
