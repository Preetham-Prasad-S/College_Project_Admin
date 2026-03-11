import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/staff_history.dart';
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
  ) async {
    final staffHistory = await _repository.getStaffHistory(params.currentTime);

    return staffHistory.fold(
      (AppFailure failure) => left(AppFailure(message: failure.message)),

      (StaffHistory data) {
        if (data.clockIn == null) {
          return right(StaffStatus(status: "clocked_out"));
        }
        if (data.clockOut == null) {
          return right(StaffStatus(status: "clocked_in"));
        }
        return right(StaffStatus(status: "completed"));
      },
    );
  }
}

class GetStaffAttendanceStatusUsecaseParams {
  final DateTime currentTime;

  GetStaffAttendanceStatusUsecaseParams({required this.currentTime});
}
