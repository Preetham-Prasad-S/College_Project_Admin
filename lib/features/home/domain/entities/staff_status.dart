import 'package:staff_app/features/home/data/models/staff_status_model.dart';

class StaffStatus {
  final String status;

  StaffStatus({required this.status});

  factory StaffStatus.fromModel(StaffStatusModel model) {
    return StaffStatus(status: model.status);
  }

  @override
  String toString() {
    return "StaffStatus(check_in : $status)";
  }
}
