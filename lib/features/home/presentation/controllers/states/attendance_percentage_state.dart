sealed class AttendancePercentageState {}

final class AttendancePercentageDataState implements AttendancePercentageState {
  final double percentage;

  AttendancePercentageDataState({required this.percentage});
}

final class AttendancePercentageErrorState
    implements AttendancePercentageState {
  final String errorMessage;

  AttendancePercentageErrorState({required this.errorMessage});
}
