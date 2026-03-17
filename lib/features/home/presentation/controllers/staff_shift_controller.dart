import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_shift_state.dart';

class StaffShiftController extends AsyncNotifier<StaffShiftState> {
  @override
  Future<StaffShiftState> build() async {
    final getStaffShiftUsecase = ref.read(getStaffShiftUsecaseProvider);

    final result = await getStaffShiftUsecase(NoParams());

    return result.fold(
      (AppFailure failure) =>
          StaffShiftErrorState(errorMessage: failure.message),
      (StaffShift shift) =>
          StaffShiftDataState(startShift: shift.start, endShift: shift.end),
    );
  }
}
