import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetHolidayDetailsUseCase
    implements FutureUsecase<CollegeHolidays?, GetHolidayDetailsParams> {
  final HomeRepository _repository;

  GetHolidayDetailsUseCase({required HomeRepository repository})
    : _repository = repository;

  @override
  Future<Either<AppFailure, CollegeHolidays?>> call(
    GetHolidayDetailsParams params,
  ) async {
    return await _repository.getHolidayDays(params.dateTime);
  }
}

class GetHolidayDetailsParams {
  final DateTime dateTime;

  GetHolidayDetailsParams({required this.dateTime});
}
