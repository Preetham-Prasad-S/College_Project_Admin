class StaffStatusModel {
  final String status;

  StaffStatusModel({required this.status});

  factory StaffStatusModel.fromJson(Map<String, dynamic> json) {
    return StaffStatusModel(status: json["check_in"]);
  }

  @override
  String toString() {
    return "StaffStatusModel(check_in : $status)";
  }
}
