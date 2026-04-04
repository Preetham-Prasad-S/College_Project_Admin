import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/attendance_details.dart';
import 'package:staff_app/features/home/domain/usescases/get_attendance_details_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/states/attendance_details_state.dart';

class AttendanceDetailsController
    extends AsyncNotifier<AttendanceDetailsState> {
  @override
  Future<AttendanceDetailsState> build() async {
    final usecase = ref.read(getAttendanceDetailsUsecaseProvider);

    final result = await usecase(
      GetAttendanceDetailsUsecaseParams(currentTime: DateTime.now()),
    );

    return result.fold(
      (AppFailure failure) =>
          AttendanceDetailsFailure(message: failure.message),
      (AttendanceDetails details) => AttendanceDetailsSuccess(
        absentDays: details.absent,
        presentDays: details.present,
        lateDays: details.lateDays,
      ),
    );
  }
}
