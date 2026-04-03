import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:staff_app/features/auth/data/models/staff_model.dart';

class AuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  AuthDatasourceImpl({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore,
       _firebaseAuth = firebaseAuth;

  @override
  Future<bool> login({required String email, required String password}) async {
    try {
      final staff = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (staff.user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw AuthException(message: "$e : AuthDatasource.login()");
    }
  }

  @override
  Future<StaffModel?> authorize(String userId) async {
    try {
      final userAuthorization = await _firebaseFirestore
          .collection("user")
          .doc(userId)
          .get();

      final userData = userAuthorization.data();

      if (userData != null) {
        return StaffModel.fromJson(userData);
      }

      return null;
    } catch (e) {
      throw AuthException(message: "$e : AuthDatasource.authorize()");
    }
  }

  @override
  Future<String?> getCurrentUserId() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser != null) {
      return currentUser.uid;
    }

    return null;
  }
}
