import 'package:fpdart/src/either.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/attendance_details.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetAttendanceDetailsUsecase
    implements
        FutureUsecase<AttendanceDetails, GetAttendanceDetailsUsecaseParams> {
  final HomeRepository _repository;

  GetAttendanceDetailsUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, GetAttendanceDetailsUsecaseParams>> call(
    GetAttendanceDetailsUsecaseParams params,
  ) async {
    final lateDays = await _repository.getLateDays(params.currentTime);
  }
}

class GetAttendanceDetailsUsecaseParams {
  final DateTime currentTime;

  GetAttendanceDetailsUsecaseParams({required this.currentTime});
}
