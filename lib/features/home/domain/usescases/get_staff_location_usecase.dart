import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class GetStaffLocationUsecase implements StreamUsecase<bool, NoParams> {
  final HomeRepository _repository;

  GetStaffLocationUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Stream<Either<AppFailure, bool>> call(NoParams params) async* {
    final currentLocation = _repository.currentLocation();
    final collegeLocationResult = await _repository.getCollegeLocation();

    if (collegeLocationResult.isLeft()) {
      yield left(collegeLocationResult.getLeft().toNullable()!);
      return;
    }
    final collegeLocation = collegeLocationResult.getRight().toNullable()!;

    yield* currentLocation.map((location) {
      return location.fold(
        (AppFailure failure) {
          return left(AppFailure(message: failure.message));
        },
        (CollegeLocation currentLocation) {
          final inPremises = _isInsideRadius(
            currentLocation,
            collegeLocation,
            1000,
          );
          return right(inPremises);
        },
      );
    });
  }

  bool _isInsideRadius(
    CollegeLocation currentLocation,
    CollegeLocation collegeLocation,
    double perimeter,
  ) {
    final distance = Geolocator.distanceBetween(
      collegeLocation.latitude,
      collegeLocation.longitude,
      currentLocation.latitude,
      currentLocation.longitude,
    );

    return distance <= perimeter;
  }
}
