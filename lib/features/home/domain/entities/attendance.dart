// ignore_for_file: public_member_api_docs, sort_constructors_first
class Attendance {
  final bool inPremises;
  final bool isClockedIn;

  Attendance({required this.inPremises, required this.isClockedIn});

  Attendance copyWith({bool? inPremises, bool? isClockedIn}) {
    return Attendance(
      inPremises: inPremises ?? this.inPremises,
      isClockedIn: isClockedIn ?? this.isClockedIn,
    );
  }
}
