import 'package:firebase_auth/firebase_auth.dart';
import "package:fpdart/fpdart.dart";
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:staff_app/features/auth/domain/enitites/auth_staff.dart';
import 'package:staff_app/features/auth/domain/enitites/staff.dart';
import 'package:staff_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl({
    required AuthDatasource authDatasource,
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth,
       _authDatasource = authDatasource;

  @override
  Future<Either<AppFailure, Staff>> login(AuthStaff authStaff) async {
    try {
      final staffUser = await _authDatasource.login(
        email: authStaff.email,
        password: authStaff.password,
      );

      if (!staffUser) {
        return left(
          AppFailure(
            message: "User Not Authendicated : AuthRepository.login()",
          ),
        );
      }

      final staff = await _authDatasource.authorize(
        _firebaseAuth.currentUser!.uid,
      );

      if (staff != null) {
        return right(Staff.fromModel(staff));
      }

      return left(
        AppFailure(message: "Authorization Not Found : AuthRepository.login()"),
      );
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<AppFailure, Staff?>> getCurrentUser() async {
    try {
      final currentUserId = await _authDatasource.getCurrentUserId();

      if (currentUserId == null) {
        return right(null);
      }

      final staff = await _authDatasource.authorize(currentUserId);

      if (staff == null) {
        return left(
          AppFailure(
            message: "Authorization Not Found : AuthRepository.getCurrentUser",
          ),
        );
      }

      return right(Staff.fromModel(staff));
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }
}
