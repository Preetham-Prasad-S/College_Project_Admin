import 'package:staff_app/features/home/data/models/working_days_model.dart';

class WorkingDays {
  final int? workingDays;

  WorkingDays({required this.workingDays});

  factory WorkingDays.fromModel(WorkingDaysModel model) {
    return WorkingDays(workingDays: model.workingDays);
  }
}
