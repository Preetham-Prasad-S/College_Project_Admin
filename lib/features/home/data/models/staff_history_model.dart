class StaffHistoryModel {
  final DateTime? clockIn;
  final DateTime? clockOut;

  StaffHistoryModel({required this.clockIn, required this.clockOut});

  factory StaffHistoryModel.fromJson(Map<String, dynamic> json) {
    return StaffHistoryModel(
      clockIn: json["clock_in"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["clock_in"] as int)
          : null,
      clockOut: json["clock_out"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["clock_out"] as int)
          : null,
    );
  }

  @override
  String toString() =>
      'StaffHistoryModel(clockIn: $clockIn, clockOut: $clockOut)';
}
