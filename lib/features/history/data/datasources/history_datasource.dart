import 'package:staff_app/features/history/data/models/month_history_model.dart';

abstract interface class HistoryDatasource {
  Future<MonthHistoryModel?> getMonthHistory(DateTime selectedTime);
  // Future<ShiftTiming> getShiftTiming(String shiftType);
}
