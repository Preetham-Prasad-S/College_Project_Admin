class Attendance {
  final bool inPremises;
  final bool isClockedIn;
  final bool isClockedOut;

  Attendance({
    required this.inPremises,
    required this.isClockedIn,
    required this.isClockedOut,
  });

  Attendance copyWith({
    bool? inPremises,
    bool? isClockedIn,
    bool? isClockedOut,
  }) {
    return Attendance(
      inPremises: inPremises ?? this.inPremises,
      isClockedIn: isClockedIn ?? this.isClockedIn,
      isClockedOut: isClockedOut ?? this.isClockedOut,
    );
  }
}
