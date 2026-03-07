import 'package:fpdart/fpdart.dart';
import 'package:geolocator/geolocator.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/domain/entities/attendance.dart';
import 'package:staff_app/features/home/domain/entities/college_location.dart';
import 'package:staff_app/features/home/domain/entities/staff_history.dart';
import 'package:staff_app/features/home/domain/repositories/home_repository.dart';

class AttendanceEntryUsecase
    implements StreamUsecase<Attendance, AttendanceEntryParams> {
  final HomeRepository _repository;

  AttendanceEntryUsecase({required HomeRepository repository})
    : _repository = repository;

  @override
  Stream<Either<AppFailure, Attendance>> call(
    AttendanceEntryParams params,
  ) async* {
    final staffHistory = await _repository.getStaffHistory(params.dateTime);
    final currentLocation = _repository.currentLocation();
    final collegeLocationResult = await _repository.getCollegeLocation();
    final staffStatusResult = await _repository.getStaffStatus();

    print(staffHistory);

    if (staffStatusResult.isLeft()) {
      yield left(staffStatusResult.getLeft().toNullable()!);
      return;
    }

    if (staffHistory.isLeft()) {
      yield left(staffStatusResult.getLeft().toNullable()!);
      return;
    }

    if (collegeLocationResult.isLeft()) {
      yield left(staffStatusResult.getLeft().toNullable()!);
      return;
    }

    final staffStatus = staffStatusResult.getRight().toNullable()!;
    final collegeLocation = collegeLocationResult.getRight().toNullable()!;
    final staffHistoryData = staffHistory.getRight().toNullable()!;

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
          return right(
            Attendance(
              inPremises: inPremises,
              isClockedIn: staffHistoryData.clockIn != null,
              isClockedOut: staffHistoryData.clockOut != null,
            ),
          );
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

class AttendanceEntryParams {
  final DateTime dateTime;

  AttendanceEntryParams({required this.dateTime});
}
