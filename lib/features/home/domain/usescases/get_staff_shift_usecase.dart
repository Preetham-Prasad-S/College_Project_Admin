import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetStaffShiftUsecase implements FutureUsecase<StaffShift, NoParams> {
  final HomeRepository _repository;

  GetStaffShiftUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, StaffShift>> call(NoParams params) async {
    return await _repository.getStaffShift();
  }
}
