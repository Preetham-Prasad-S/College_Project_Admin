import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';

class StaffMonthlyHistoryModel {
  final Map<int, StaffHistoryDataModel> historyData;

  factory StaffMonthlyHistoryModel.fromJson(
    Map<String, Map<String, dynamic>> json,
  ) {
    return StaffMonthlyHistoryModel(
      historyData: json.map(
        (key, value) => MapEntry(
          int.parse(key),
          StaffHistoryDataModel(
            clockIn: DateTime.fromMillisecondsSinceEpoch(
              value["clock_in"] as int,
            ),
            clockOut: DateTime.fromMillisecondsSinceEpoch(
              value["clock_out"] as int,
            ),
            lateEntry: value["late_entry"],
            lateExit: value["late_exit"],
            status: value["status"],
          ),
        ),
      ),
    );
  }

  StaffMonthlyHistoryModel({required this.historyData});
}
