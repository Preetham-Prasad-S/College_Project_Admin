import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/attendance_details.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';
import 'package:staff_app/features/home/domain/entities/working_days.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetAttendanceDetailsUsecase
    implements
        FutureUsecase<AttendanceDetails, GetAttendanceDetailsUsecaseParams> {
  final HomeRepository _repository;

  GetAttendanceDetailsUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, AttendanceDetails>> call(
    GetAttendanceDetailsUsecaseParams params,
  ) async {
    final lateDaysData = await _repository.getLateDays(params.currentTime);
    final attendedDaysData = await _repository.getAttendedDays(
      params.currentTime,
    );
    final holidaysData = await _repository.getHolidayDays(params.currentTime);

    return lateDaysData.fold(
      (AppFailure failure) => left(AppFailure(message: failure.message)),
      (WorkingDays lateEntry) {
        return attendedDaysData.fold(
          (AppFailure failure) => left(AppFailure(message: failure.message)),
          (WorkingDays attendedEntry) {
            return holidaysData.fold(
              (AppFailure failure) =>
                  left(AppFailure(message: failure.message)),
              (CollegeHolidays? holidays) {
                final today = params.currentTime;

                int holidayCount = 0;

                final mountStart = DateTime(
                  params.currentTime.year,
                  params.currentTime.month,
                  1,
                );

                final daysPassed = today.difference(mountStart).inDays + 1;

                holidayCount =
                    holidays?.holidayDates
                        ?.where(
                          (h) =>
                              h.date.isBefore(today) ||
                              h.date.isAtSameMomentAs(today),
                        )
                        .length ??
                    0;

                final absentDays =
                    daysPassed - attendedEntry.workingDays - holidayCount;
                final presentDays =
                    attendedEntry.workingDays - lateEntry.workingDays;

                return right(
                  AttendanceDetails(
                    present: presentDays,
                    absent: absentDays,
                    lateDays: lateEntry.workingDays,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class GetAttendanceDetailsUsecaseParams {
  final DateTime currentTime;
  GetAttendanceDetailsUsecaseParams({required this.currentTime});
}
