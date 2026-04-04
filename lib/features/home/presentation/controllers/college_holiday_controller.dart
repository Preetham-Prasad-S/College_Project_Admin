import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/college_holiday.dart';
import 'package:staff_app/features/home/domain/usescases/get_holiday_details_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/states/college_holiday_state.dart';

class CollegeHolidayController extends AsyncNotifier<CollegeHolidayState> {
  @override
  Future<CollegeHolidayState> build() async {
    final getHolidayDetailsUseCase = ref.read(getHolidayDetailsUsecaseProvider);

    final holidays = await getHolidayDetailsUseCase(
      GetHolidayDetailsParams(dateTime: DateTime.now()),
    );

    return holidays.fold(
      (AppFailure failure) => CollegeHolidayErrorState(error: failure.message),
      (CollegeHolidays? data) => CollegeHolidayDataState(holidays: data),
    );
  }
}
