import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/entities/staff_status.dart';
import 'package:staff_app/features/home/domain/enums/staff_status_enum.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/set_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/states/location_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_shift_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_status_state.dart';

class StaffAttendanceStatusController extends AsyncNotifier<StaffStatusState> {
  @override
  Future<StaffStatusState> build() async {
    final getStaffAttendanceStatusUsecase = ref.read(
      getStaffAttendanceStatusUsecaseProvider,
    );

    final staffStatus = await getStaffAttendanceStatusUsecase(
      GetStaffAttendanceStatusUsecaseParams(currentTime: DateTime.now()),
    );

    return staffStatus.fold(
      (AppFailure failure) =>
          StaffStatusErrorState(errorMessage: failure.message),
      (StaffStatus status) {
        if (status.status == StaffStatusEnum.clockedIn) {
          return StaffStatusClockedInState();
        } else if (status.status == StaffStatusEnum.clockedOut) {
          return StaffStatusClockedOutState();
        } else {
          return StaffStatusCompletedState();
        }
      },
    );
  }

  Future<void> attendancEntry(String type) async {
    final setStaffStatus = ref.read(setStaffAttendanceStatusUsecaseProvider);
    final location = await ref.read(staffLocationControllerProvider.future);
    final getStaffShift = ref.read(getStaffShiftControllerProvider);
    final currentTime = DateTime.now();

    bool isLate = false;

    if (location is LocationDataState) {
      if (location.inCampus) {
        getStaffShift.when(
          data: (data) {
            return data is StaffShiftDataState
                ? type == "clock_in"
                      ? isLate = currentTime.isAfter(data.startShift)
                      : isLate = currentTime.isAfter(data.endShift)
                : isLate = false;
          },
          error: (error, stackTrace) => null,
          loading: () => null,
        );

        await setStaffStatus(
          SetStaffAttendanceStatusUsecaseParmas(
            staffEntry: StaffAttendanceEntry(
              entry: currentTime,
              isLate: isLate,
              type: type,
            ),
          ),
        );
      }
    }
  }
}
