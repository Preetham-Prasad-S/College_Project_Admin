import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/auth/domain/enitites/auth_staff.dart';
import 'package:staff_app/features/auth/domain/enitites/staff.dart';
import 'package:staff_app/features/auth/domain/repositories/auth_repository.dart';

class Login implements FutureUsecase<Staff, LoginParams> {
  final AuthRepository _authRespository;

  Login({required AuthRepository authRespository})
    : _authRespository = authRespository;

  @override
  Future<Either<AppFailure, Staff>> call(LoginParams params) async {
    return await _authRespository.login(params.authStaff);
  }
}

class LoginParams {
  final AuthStaff authStaff;

  LoginParams({required this.authStaff});
}
