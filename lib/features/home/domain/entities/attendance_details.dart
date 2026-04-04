// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttendanceDetails {
  final int present;
  final int absent;
  final int lateDays;

  AttendanceDetails({
    required this.present,
    required this.absent,
    required this.lateDays,
  });

  @override
  String toString() =>
      'AttendanceDetails(present: $present, absent: $absent, lateDays: $lateDays)';
}
