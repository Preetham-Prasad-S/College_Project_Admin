import 'package:staff_app/features/auth/data/models/staff_model.dart';

abstract interface class AuthDatasource {
  Future<bool> login({required String email, required String password});
  Future<StaffModel?> authorize(String userId);
  Future<String?> getCurrentUserId();
}
