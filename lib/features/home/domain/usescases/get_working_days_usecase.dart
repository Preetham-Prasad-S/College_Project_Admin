import 'package:fpdart/src/either.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/working_days.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetWorkingDaysUsecase
    implements FutureUsecase<WorkingDays, GetWorkingDaysParams> {
  final HomeRepository _repository;

  GetWorkingDaysUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, WorkingDays>> call(
    GetWorkingDaysParams params,
  ) async {
    return await _repository.getWorkingDays(params.currentDate);
  }
}

class GetWorkingDaysParams {
  final DateTime currentDate;

  GetWorkingDaysParams({required this.currentDate});
}
