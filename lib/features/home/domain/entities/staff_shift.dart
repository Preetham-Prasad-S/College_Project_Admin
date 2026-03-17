import 'package:staff_app/features/home/data/models/staff_shift_model.dart';

class StaffShift {
  final DateTime start;
  final DateTime end;

  StaffShift({required this.start, required this.end});

  factory StaffShift.fromModel(StaffShiftModel model) {
    return StaffShift(start: model.start, end: model.end);
  }

  @override
  String toString() {
    return "StaffShift(start : $start, end : $end)";
  }
}
