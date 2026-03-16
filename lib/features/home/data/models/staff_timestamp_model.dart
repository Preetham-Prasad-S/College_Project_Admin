class StaffTimestampModel {
  final DateTime? clockIn;
  final DateTime? clockOut;

  StaffTimestampModel({required this.clockIn, required this.clockOut});

  factory StaffTimestampModel.fromJson(Map<String, dynamic> json) {
    return StaffTimestampModel(
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
      'StaffTimestampModel(clockIn: $clockIn, clockOut: $clockOut)';
}
