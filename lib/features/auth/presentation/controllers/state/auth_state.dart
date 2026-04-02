import 'package:staff_app/features/auth/domain/enitites/staff.dart';

sealed class AuthState {}

final class AuthSuccessState implements AuthState {
  final Staff staff;

  AuthSuccessState({required this.staff});
}

final class AuthFailureState implements AuthState {
  final String message;

  AuthFailureState({required this.message});
}
