import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';

class StaffTimestamp {
  final DateTime? clockIn;
  final DateTime? clockOut;

  StaffTimestamp({required this.clockIn, required this.clockOut});

  factory StaffTimestamp.fromModel(StaffHistoryDataModel model) {
    return StaffTimestamp(clockIn: model.clockIn, clockOut: model.clockOut);
  }

  @override
  String toString() => 'StaffHistory(clockIn: $clockIn, clockOut: $clockOut)';
}
