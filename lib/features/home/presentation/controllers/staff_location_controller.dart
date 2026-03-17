import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/attendance.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/enums/staff_status_enum.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_location_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/states/attendance_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/location_state.dart';

class StaffLocationController extends StreamNotifier<LocationState> {
  @override
  Stream<LocationState> build() async* {
    final getStaffLocationUsecase = ref.read(getStaffLocationUsecaseProvider);

    final inPremises = getStaffLocationUsecase(NoParams());

    yield* inPremises.map((location) {
      return location.fold(
        (AppFailure failure) =>
            LocationErrorState(errorMessage: failure.message),
        (bool inCampus) => LocationDataState(inCampus: inCampus),
      );
    });
  }
}
