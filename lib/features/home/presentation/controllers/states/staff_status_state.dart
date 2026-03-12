sealed class StaffStatusState {}

final class StaffStatusClockedInState implements StaffStatusState {}

final class StaffStatusClockedOutState implements StaffStatusState {}

final class StaffStatusCompletedState implements StaffStatusState {}

final class StaffStatusErrorState implements StaffStatusState {
  final String errorMessage;

  StaffStatusErrorState({required this.errorMessage});
}
