import 'package:staff_app/features/auth/data/models/staff_model.dart';

class Staff {
  final String authorization;
  final String name;
  final String staffId;
  final String email;
  final int phoneNumber;
  final String userId;

  Staff({
    required this.name,
    required this.staffId,
    required this.email,
    required this.phoneNumber,
    required this.userId,
    required this.authorization,
  });

  factory Staff.fromModel(StaffModel model) {
    return Staff(
      name: model.name,
      staffId: model.staffId,
      email: model.email,
      phoneNumber: model.phoneNumber,
      userId: model.userId,
      authorization: model.authorization,
    );
  }

  @override
  String toString() {
    return 'Staff(name: $name, staffId: $staffId, email: $email, phoneNumber: $phoneNumber, userId: $userId, authorization : $authorization)';
  }
}
