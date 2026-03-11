class StaffHistoryModel {
  final DateTime? clockIn;
  final DateTime? clockOut;

  StaffHistoryModel({required this.clockIn, required this.clockOut});

  factory StaffHistoryModel.fromJson(Map<String, dynamic> json) {
    return StaffHistoryModel(
      clockIn: DateTime.fromMillisecondsSinceEpoch(json["clock_in"] as int),
      clockOut: DateTime.fromMillisecondsSinceEpoch(json["clock_out"] as int),
    );
  }

  @override
  String toString() =>
      'StaffHistoryModel(clockIn: $clockIn, clockOut: $clockOut)';
}
