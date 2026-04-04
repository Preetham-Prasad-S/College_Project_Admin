sealed class AttendanceDetailsState {}

final class AttendanceDetailsSuccess implements AttendanceDetailsState {
  final int presentDays;
  final int absentDays;
  final int lateDays;

  AttendanceDetailsSuccess({
    required this.presentDays,
    required this.absentDays,
    required this.lateDays,
  });
}

final class AttendanceDetailsFailure implements AttendanceDetailsState {
  final String message;

  AttendanceDetailsFailure({required this.message});
}
