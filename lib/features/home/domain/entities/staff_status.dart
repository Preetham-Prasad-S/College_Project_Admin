class StaffStatus {
  final bool status;

  StaffStatus({required this.status});

  factory StaffStatus.fromJson(Map<String, dynamic> json) {
    return StaffStatus(status: json["check_in"]);
  }

  @override
  String toString() {
    return "StaffStatus(check_in : $status)";
  }
}
