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
    final setHistory = await _repository.setStaffHistory(params.staffEntry);

    return setHistory.fold(
      (AppFailure failure) => left(AppFailure(message: failure.message)),
      (_) => right(null),
    );
  }
}

class SetStaffAttendanceStatusUsecaseParmas {
  final StaffAttendanceEntry staffEntry;

  SetStaffAttendanceStatusUsecaseParmas({required this.staffEntry});
}
