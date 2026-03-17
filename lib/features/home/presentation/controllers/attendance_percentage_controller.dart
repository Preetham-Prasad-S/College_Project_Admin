import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/attendance_percentage.dart';
import 'package:staff_app/features/home/domain/usescases/get_attendance_percentage_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/states/attendance_percentage_state.dart';

class AttendancePercentageController
    extends AsyncNotifier<AttendancePercentageState> {
  @override
  Future<AttendancePercentageState> build() async {
    final attendancePercentageUsecase = ref.read(
      getAttendancePercentageUsecase,
    );

    final percentage = await attendancePercentageUsecase(
      GetAttendancePercentageUsecaseParams(currentDate: DateTime.now()),
    );

    return percentage.fold(
      (AppFailure failure) =>
          AttendancePercentageErrorState(errorMessage: failure.message),
      (AttendancePercentage attendance) =>
          AttendancePercentageDataState(percentage: attendance.percentage),
    );
  }
}
