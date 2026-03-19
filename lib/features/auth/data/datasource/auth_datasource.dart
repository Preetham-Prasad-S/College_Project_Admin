import 'package:staff_app/features/auth/data/models/staff_model.dart';

abstract interface class AuthDatasource {
  Future<StaffModel> login({required String email, required String password});
}
