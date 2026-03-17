class StaffHistoryDataModel {
  final DateTime? clockIn;
  final DateTime? clockOut;
  final bool lateEntry;
  final bool lateExit;
  final String status;

  StaffHistoryDataModel({
    required this.clockIn,
    required this.clockOut,
    required this.lateEntry,
    required this.lateExit,
    required this.status,
  });

  factory StaffHistoryDataModel.fromJson(Map<String, dynamic> json) {
    return StaffHistoryDataModel(
      clockIn: json["clock_in"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["clock_in"] as int)
          : null,
      clockOut: json["clock_out"] != null
          ? DateTime.fromMillisecondsSinceEpoch(json["clock_out"] as int)
          : null,
      lateEntry: (json["late_entry"] ?? false) as bool,
      lateExit: (json["late_exit"] ?? false) as bool,
      status: json["status"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "clock_in": clockIn?.millisecondsSinceEpoch,
      "clock_out": clockOut?.millisecondsSinceEpoch,
      "late_entry": lateEntry,
      "late_exit": lateExit,
      "status": status,
    };
  }

  @override
  String toString() {
    return 'StaffHistoryDataModel(clockIn: $clockIn, clockOut: $clockOut, lateEntry: $lateEntry, lateExit: $lateExit, status: $status)';
  }
}
