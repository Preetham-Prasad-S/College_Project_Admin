import 'package:staff_app/features/home/domain/enums/staff_status_enum.dart';

class StaffStatus {
  final StaffStatusEnum status;

  StaffStatus({required this.status});

  @override
  String toString() {
    return "StaffStatus(check_in : $status)";
  }
}
