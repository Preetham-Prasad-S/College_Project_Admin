import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';

class StaffShiftController extends AsyncNotifier<AsyncValue<StaffShift>> {
  @override
  Future<AsyncValue<StaffShift>> build() async {
    final getStaffShiftUsecase = ref.read(getStaffShiftUsecaseProvider);

    final result = await getStaffShiftUsecase(NoParams());

    return result.fold(
      (AppFailure failure) => AsyncError(failure.message, StackTrace.current),
      (StaffShift shift) => AsyncData(shift),
    );
  }
}
