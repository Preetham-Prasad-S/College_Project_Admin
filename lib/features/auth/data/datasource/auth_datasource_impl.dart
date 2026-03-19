import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:staff_app/features/auth/data/models/staff_model.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthDatasourceImpl({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  @override
  Future<StaffModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final staff = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (staff.user != null) {
        return StaffModel();
      } else {
        throw AuthException(message: "No User Found : AuthDatasource.login()");
      }
    } catch (e) {
      throw AuthException(message: "$e : AuthDatasource.login()");
    }
  }
}
