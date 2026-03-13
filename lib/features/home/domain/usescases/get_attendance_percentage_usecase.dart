import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/attendance_percentage.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';
import 'package:staff_app/features/home/domain/entities/working_days.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetAttendancePercentageUsecase
    implements
        FutureUsecase<
          AttendancePercentage,
          GetAttendancePercentageUsecaseParams
        > {
  final HomeRepository _repository;

  GetAttendancePercentageUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, AttendancePercentage>> call(
    GetAttendancePercentageUsecaseParams params,
  ) async {
    final DateTime today = params.currentDate;
    final DateTime monthStart = DateTime(
      params.currentDate.year,
      params.currentDate.month,
      1,
    );

    final attendedDays = await _repository.getAttendedDays(params.currentDate);

    final holidayDays = await _repository.getHolidayDays(params.currentDate);

    return attendedDays.fold((failure) => left(failure), (WorkingDays workDay) {
      return holidayDays.fold((failure) => left(failure), (
        CollegeHolidays holidays,
      ) {
        int daysPassed = today.difference(monthStart).inDays + 1;

        int sundayCount = 0;

        for (int i = 0; i < daysPassed; i++) {
          final day = monthStart.add(Duration(days: i));

          if (day.weekday == DateTime.sunday) {
            sundayCount++;
          }
        }

        int holidayCount =
            holidays.holidayDates
                ?.where(
                  (h) =>
                      h.date.isBefore(today) || h.date.isAtSameMomentAs(today),
                )
                .length ??
            0;

        int workingDaysPassed = daysPassed - sundayCount - holidayCount;

        double percentage = 0;

        if (workingDaysPassed > 0) {
          percentage = (workDay.workingDays! / workingDaysPassed) * 100;
        }

        return right(AttendancePercentage(percentage: percentage));
      });
    });
  }
}

class GetAttendancePercentageUsecaseParams {
  final DateTime currentDate;

  GetAttendancePercentageUsecaseParams({required this.currentDate});
}
