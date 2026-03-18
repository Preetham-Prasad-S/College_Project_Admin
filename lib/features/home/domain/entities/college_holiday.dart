// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:staff_app/features/home/data/models/college_holidays_model.dart';

class CollegeHolidays {
  final List<HolidayInfo>? holidayDates;

  CollegeHolidays({required this.holidayDates});

  factory CollegeHolidays.fromModel(CollegeHolidaysModel model) {
    return CollegeHolidays(
      holidayDates: model.holidayDates
          ?.map(
            (holiday) => HolidayInfo(
              name: holiday.name,
              date: holiday.date,
              type: holiday.type,
            ),
          )
          .toList(),
    );
  }

  @override
  String toString() => 'CollegeHolidays(holidayDates: $holidayDates)';
}

class HolidayInfo {
  final String name;
  final DateTime date;
  final String type;

  HolidayInfo({required this.name, required this.date, required this.type});

  @override
  String toString() => 'HolidayInfo(name: $name, date: $date, type: $type)';
}
