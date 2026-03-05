import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';

abstract interface class Usecase<UseType, Params> {
  Future<Either<AppFailure, UseType>> call();
}
