import 'package:fpdart/src/either.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetStaffAttendanceStatusUsecase
    implements
        FutureUsecase<StaffStatus, GetStaffAttendanceStatusUsecaseParams> {
  final HomeRepository _repository;

  GetStaffAttendanceStatusUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, StaffStatus>> call(
    GetStaffAttendanceStatusUsecaseParams params,
  ) {
    // TODO: implement call
    throw UnimplementedError();
  }
}

class GetStaffAttendanceStatusUsecaseParams {
  final DateTime currentTime;

  GetStaffAttendanceStatusUsecaseParams({required this.currentTime});
}
