import 'package:staff_app/features/home/domain/entities/college_holiday.dart';

sealed class CollegeHolidayState {}

final class CollegeHolidayDataState implements CollegeHolidayState {
  final CollegeHolidays? holidays;

  CollegeHolidayDataState({required this.holidays});
}

final class CollegeHolidayErrorState implements CollegeHolidayState {
  final String error;

  CollegeHolidayErrorState({required this.error});
}
