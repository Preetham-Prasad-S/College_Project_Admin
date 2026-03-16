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
}
