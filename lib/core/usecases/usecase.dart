import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';

abstract interface class FutureUsecase<UseType, Params> {
  Future<Either<AppFailure, UseType>> call(Params params);
}

abstract interface class StreamUsecase<UseType, Params> {
  Stream<Either<AppFailure, UseType>> call(Params params);
}

class NoParams {}
