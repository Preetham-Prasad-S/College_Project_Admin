// ignore_for_file: public_member_api_docs, sort_constructors_first
class AttendanceEnabled {
  final bool inPremises;
  final bool isClockedIn;

  AttendanceEnabled({required this.inPremises, required this.isClockedIn});

  AttendanceEnabled copyWith({bool? inPremises, bool? isClockedIn}) {
    return AttendanceEnabled(
      inPremises: inPremises ?? this.inPremises,
      isClockedIn: isClockedIn ?? this.isClockedIn,
    );
  }
}
