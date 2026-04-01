class StaffModel {
  final String authorization;
  final String name;
  final String staffId;
  final String email;
  final int phoneNumber;
  final String userId;

  StaffModel({
    required this.name,
    required this.staffId,
    required this.email,
    required this.phoneNumber,
    required this.userId,
    required this.authorization,
  });

  factory StaffModel.fromJson(Map<String, dynamic> json) {
    return StaffModel(
      name: json["name"],
      staffId: json["staff_id"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      userId: json["user_id"],
      authorization: json["authorization"],
    );
  }

  @override
  String toString() {
    return 'StaffModel(name: $name, staffId: $staffId, email: $email, phoneNumber: $phoneNumber, userId: $userId, authorization : $authorization)';
  }
}
