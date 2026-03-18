class CollegeHolidays {
  final List<HolidayInfo> holidayDates;

  CollegeHolidays({required this.holidayDates});

  @override
  String toString() => 'CollegeHolidays(holidayDates: $holidayDates)';
}

class HolidayInfo {
  final String name;
  final DateTime date;
  final String type;

  HolidayInfo({required this.name, required this.date, required this.type});
}
