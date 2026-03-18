// ignore_for_file: public_member_api_docs, sort_constructors_first
class CollegeHolidaysModel {
  final List<HolidayModel>? holidayDates;

  CollegeHolidaysModel({required this.holidayDates});

  factory CollegeHolidaysModel.fromJson(List<dynamic> json) {
    return CollegeHolidaysModel(
      holidayDates: json
          .map(
            (holiday) => HolidayModel.fromJson(holiday as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  @override
  String toString() => 'CollegeHolidaysModel(holidayDates: $holidayDates)';
}

class HolidayModel {
  final DateTime date;
  final String name;
  final String type;

  factory HolidayModel.fromJson(Map<String, dynamic> json) {
    return HolidayModel(
      date: json['date'],
      name: json['name'],
      type: json['name'],
    );
  }

  HolidayModel({required this.date, required this.name, required this.type});
}
