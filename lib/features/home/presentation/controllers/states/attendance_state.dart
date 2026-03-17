import 'package:staff_app/features/home/domain/enums/staff_status_enum.dart';

sealed class AttendanceState {}

final class AttendanceLoadingState implements AttendanceState {}

final class AttendanceDataState implements AttendanceState {
  final StaffStatusEnum state;

  AttendanceDataState({required this.state});
}

final class AttendanceErrorState implements AttendanceState {
  final String errorMessage;

  AttendanceErrorState({required this.errorMessage});
}
