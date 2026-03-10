import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/attendance.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/domain/usescases/attendance_entry_usecase.dart';

class AttendanceEntryController extends StreamNotifier<AsyncValue<Attendance>> {
  @override
  Stream<AsyncValue<Attendance>> build() {
    final attendanceEntryUsecase = ref.read(attendanceEntryUsecaseProvider);

    final result = attendanceEntryUsecase(
      AttendanceEntryParams(dateTime: DateTime(2023, 1, 1)),
    );

    return result.map((attendance) {
      return attendance.fold(
        (AppFailure failure) => AsyncError(failure.message, StackTrace.current),
        (Attendance attendance) => AsyncData(attendance),
      );
    });
  }

  Future<AsyncValue<StaffShift>> getStaffShift() async {
    final getStaffShiftUsecase = ref.read(getStaffShiftUsecaseProvider);

    final result = await getStaffShiftUsecase(NoParams());

    return result.fold(
      (AppFailure failure) => AsyncError(failure.message, StackTrace.current),
      (StaffShift shift) => AsyncData(shift),
    );
  }
}
