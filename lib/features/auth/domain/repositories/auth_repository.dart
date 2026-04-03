import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/auth/domain/enitites/auth_staff.dart';
import 'package:staff_app/features/auth/domain/enitites/staff.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, Staff>> login(AuthStaff authStaff);
  Future<Either<AppFailure, Staff?>> getCurrentUser();
}
