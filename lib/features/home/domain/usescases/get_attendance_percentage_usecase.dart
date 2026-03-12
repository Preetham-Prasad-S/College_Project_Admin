import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/attendance_percentage.dart';
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
    final attendedDays = await _repository.getAttendedDays(params.currentDate);
    final workingDays = await _repository.getWorkingDays(params.currentDate);

    return attendedDays.fold(
      (AppFailure failure) => left(AppFailure(message: failure.message)),
      (WorkingDays workDay) {
        return workingDays.fold(
          (AppFailure failure) => left(AppFailure(message: failure.message)),
          (WorkingDays attendedDay) => right(
            AttendancePercentage(
              percentage:
                  ((workDay.workingDays! / attendedDay.workingDays!) * 100),
            ),
          ),
        );
      },
    );
  }
}

class GetAttendancePercentageUsecaseParams {
  final DateTime currentDate;

  GetAttendancePercentageUsecaseParams({required this.currentDate});
}
