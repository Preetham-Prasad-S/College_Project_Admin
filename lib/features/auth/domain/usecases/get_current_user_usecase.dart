import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/auth/domain/enitites/staff.dart';
import 'package:staff_app/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase implements FutureUsecase<Staff?, NoParams> {
  final AuthRepository _authRepository;

  GetCurrentUserUsecase({required AuthRepository authRepository})
    : _authRepository = authRepository;

  @override
  Future<Either<AppFailure, Staff?>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}
