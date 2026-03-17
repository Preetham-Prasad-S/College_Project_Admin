sealed class StaffShiftState {}

class StaffShiftDataState implements StaffShiftState {
  final DateTime startShift;
  final DateTime endShift;

  StaffShiftDataState({required this.startShift, required this.endShift});
}

class StaffShiftErrorState implements StaffShiftState {
  final String errorMessage;

  StaffShiftErrorState({required this.errorMessage});
}
