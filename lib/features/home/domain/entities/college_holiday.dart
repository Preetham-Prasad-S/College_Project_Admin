import 'package:staff_app/features/home/data/models/college_holidays_model.dart';

class CollegeHolidays {
  final List<HolidayInfo>? holidayDates;

  CollegeHolidays({required this.holidayDates});

  factory CollegeHolidays.fromModel(CollegeHolidaysModel model) {
    return CollegeHolidays(
      holidayDates: model.holidayDates != null
          ? model.holidayDates!
                .map(
                  (data) => HolidayInfo(
                    name: data["name"],
                    date: DateTime.fromMillisecondsSinceEpoch(
                      data["date"] as int,
                    ),
                  ),
                )
                .toList()
          : [],
    );
  }
}

class HolidayInfo {
  final String name;
  final DateTime date;

  HolidayInfo({required this.name, required this.date});
}
