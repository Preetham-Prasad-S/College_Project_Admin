import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class SetStaffAttendanceStatusUsecase
    implements FutureUsecase<void, SetStaffAttendanceStatusUsecaseParmas> {
  final HomeRepository _repository;

  SetStaffAttendanceStatusUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, void>> call(
    SetStaffAttendanceStatusUsecaseParmas params,
  ) async {
    return await _repository.setStaffStatus(params.staffEntry);
  }
}

class SetStaffAttendanceStatusUsecaseParmas {
  final StaffAttendanceEntry staffEntry;

  SetStaffAttendanceStatusUsecaseParmas({required this.staffEntry});
}
