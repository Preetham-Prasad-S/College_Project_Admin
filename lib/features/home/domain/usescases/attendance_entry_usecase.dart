import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/attendance_enabled.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class AttendanceEntryUsecase
    implements StreamUsecase<AttendanceEnabled, NoParams> {
  final HomeRepository _repository;

  AttendanceEntryUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Stream<Either<AppFailure, AttendanceEnabled>> call(NoParams params) async* {
    AttendanceEnabled attendanceEnabled = AttendanceEnabled(
      inPremises: false,
      isClockedIn: false,
    );
    CollegeLocation collegeLocation;
    final currentLocation = _repository.currentLocation();
    final collegeLocationData = await _repository.getCollegeLocation();
    final staffStatusResult = await _repository.getStaffStatus();

    staffStatusResult.fold((l) => print(l.message), (r) => print(r));

    // if (staffStatusResult.isLeft()) {
    //   yield left(
    //     staffStatusResult.getLeft().toNullable() ??
    //         AppFailure(message: "hello"),
    //   );
    //   return;
    // }

    // final staffStatus = staffStatusResult.getRight().toNullable();

    yield* currentLocation.map((location) {
      return location.fold(
        (AppFailure failure) {
          return left(AppFailure(message: failure.message));
        },
        (CollegeLocation currentLocation) {
          return right(AttendanceEnabled(inPremises: true, isClockedIn: true));
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
