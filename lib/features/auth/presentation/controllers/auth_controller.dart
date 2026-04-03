import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/dependency.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/auth/dependency.dart';
import 'package:staff_app/features/auth/domain/enitites/auth_staff.dart';
import 'package:staff_app/features/auth/domain/enitites/staff.dart';
import 'package:staff_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:staff_app/features/auth/presentation/controllers/state/auth_state.dart';

class AuthController extends AsyncNotifier<AuthState> {
  @override
  Future<AuthState> build() async {
    final getCurrentUserUsecase = ref.read(getCurrentUserUsecaseProvider);

    final currentUser = await getCurrentUserUsecase(NoParams());

    return currentUser.fold((AppFailure failure) => AuthInitialState(), (
      Staff? staff,
    ) {
      if (staff != null) {
        ref.read(currentUserProvider.notifier).state = staff;
        return AuthSuccessState(staff: staff);
      }
      return AuthInitialState();
    });
  }

  Future<void> login(String email, String password) async {
    final loginUsecase = ref.read(loginUsecaseProvider);

    state = const AsyncLoading();

    final result = await loginUsecase(
      LoginUsecaseParams(
        authStaff: AuthStaff(email: email, password: password),
      ),
    );

    state = result.fold(
      (AppFailure failure) => AsyncError(failure.message, StackTrace.current),
      (Staff staff) {
        ref.read(currentUserProvider.notifier).state = staff;

        return AsyncData(AuthSuccessState(staff: staff));
      },
    );
  }
}
