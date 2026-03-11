class StaffAttendanceEntryModel {
  final DateTime entry;
  final String type;

  StaffAttendanceEntryModel({required this.entry, required this.type});

  Map<String, dynamic> toJson() {
    return {
      "${entry.year}": {
        "${entry.month}": {
          "${entry.day}": {type: entry.millisecondsSinceEpoch},
        },
      },
    };
  }
}
