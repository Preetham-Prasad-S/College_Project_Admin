import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/auth/domain/enitites/auth_staff.dart';
import 'package:staff_app/features/auth/domain/enitites/staff.dart';
import 'package:staff_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements FutureUsecase<Staff, LoginUsecaseParams> {
  final AuthRepository _authRespository;

  LoginUsecase({required AuthRepository authRespository})
    : _authRespository = authRespository;

  @override
  Future<Either<AppFailure, Staff>> call(LoginUsecaseParams params) async {
    return await _authRespository.login(params.authStaff);
  }
}

class LoginUsecaseParams {
  final AuthStaff authStaff;

  LoginUsecaseParams({required this.authStaff});
}
