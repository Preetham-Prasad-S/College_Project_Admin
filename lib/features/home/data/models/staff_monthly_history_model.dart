import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';

class StaffMonthlyHistoryModel {
  final Map<int, StaffHistoryDataModel> historyData;

  StaffMonthlyHistoryModel({required this.historyData});

  factory StaffMonthlyHistoryModel.fromJson(Map<String, dynamic> json) {
    return StaffMonthlyHistoryModel(
      historyData: json.map(
        (key, value) => MapEntry<int, StaffHistoryDataModel>(
          int.parse(key),
          StaffHistoryDataModel.fromJson(value as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return historyData.map((key, value) => MapEntry("$key", value.toJson()));
  }

  @override
  String toString() => 'StaffMonthlyHistoryModel(historyData: $historyData)';
}
