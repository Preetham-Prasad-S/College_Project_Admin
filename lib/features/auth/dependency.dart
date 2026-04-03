import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/dependency.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource_impl.dart';
import 'package:staff_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:staff_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:staff_app/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:staff_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:staff_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:staff_app/features/auth/presentation/controllers/state/auth_state.dart';

final authDatasourceProvider = Provider<AuthDatasource>(
  (ref) => AuthDatasourceImpl(
    firebaseAuth: ref.read(firebaseAuthInstanceProvider),
    firebaseFirestore: ref.read(firebaseStoreageInstanceProvider),
  ),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    authDatasource: ref.read(authDatasourceProvider),
    firebaseAuth: ref.read(firebaseAuthInstanceProvider),
  ),
);

final loginUsecaseProvider = Provider<LoginUsecase>(
  (ref) => LoginUsecase(authRespository: ref.read(authRepositoryProvider)),
);

final getCurrentUserUsecaseProvider = Provider<GetCurrentUserUsecase>(
  (ref) =>
      GetCurrentUserUsecase(authRepository: ref.read(authRepositoryProvider)),
);

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthState>(
  () => AuthController(),
);
