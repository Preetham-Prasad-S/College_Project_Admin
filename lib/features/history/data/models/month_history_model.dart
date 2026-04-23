class MonthHistoryModel {
  final Map<int, HistoryData> monthHistoryData;

  MonthHistoryModel({required this.monthHistoryData});

  factory MonthHistoryModel.fromJson(Map<String, dynamic> json) {
    return MonthHistoryModel(
      monthHistoryData: json.map(
        (key, value) => MapEntry(int.parse(key), HistoryData.fromJson(value)),
      ),
    );
  }
}

class HistoryData {
  final DateTime clockInTime;
  final DateTime clockOutTime;
  final bool lateEntry;
  final bool lateExit;
  final String status;

  HistoryData({
    required this.clockInTime,
    required this.clockOutTime,
    required this.status,
    required this.lateEntry,
    required this.lateExit,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      clockInTime: DateTime.fromMillisecondsSinceEpoch(json['clock_in']),
      clockOutTime: DateTime.fromMillisecondsSinceEpoch(json['clock_out']),
      status: json['status'],
      lateEntry: json['late_entry'],
      lateExit: json['late_exit'],
    );
  }
}
