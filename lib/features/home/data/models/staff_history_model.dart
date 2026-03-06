class StaffHistoryModel {
  final DateTime? clockIn;
  final DateTime? clockOut;

  StaffHistoryModel({required this.clockIn, required this.clockOut});

  factory StaffHistoryModel.fromJson(Map<String, dynamic> json) {
    return StaffHistoryModel(
      clockIn: DateTime.fromMicrosecondsSinceEpoch(json["clock_in"] as int),
      clockOut: DateTime.fromMicrosecondsSinceEpoch(json["clock_out"] as int),
    );
  }

  @override
  String toString() =>
      'StaffHistoryModel(clockIn: $clockIn, clockOut: $clockOut)';
}
