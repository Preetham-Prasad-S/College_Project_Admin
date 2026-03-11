sealed class LocationState {}

final class LocationDataState implements LocationState {
  final bool inCampus;

  LocationDataState({required this.inCampus});
}

final class LocationErrorState implements LocationState {
  final String errorMessage;

  LocationErrorState({required this.errorMessage});
}

final class LocationLoadingState implements LocationState {}
