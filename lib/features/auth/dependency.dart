import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/dependency.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource_impl.dart';

final authDatasourceProvider = Provider<AuthDatasource>(
  (ref) => AuthDatasourceImpl(
    firebaseAuth: ref.read(firebaseAuthInstanceProvider),
    firebaseFirestore: ref.read(firebaseStoreageInstanceProvider),
  ),
);
