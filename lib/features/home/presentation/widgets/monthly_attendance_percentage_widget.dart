import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/presentation/controllers/states/attendance_percentage_state.dart';

class MonthlyAttendancePercentageWidget extends ConsumerWidget {
  const MonthlyAttendancePercentageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendancePercentage = ref.watch(
      attendancePercentageControllerProvider,
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
        side: BorderSide(color: Color.fromRGBO(215, 226, 243, 1), width: 1.5),
      ),
      color: Color.fromRGBO(231, 240, 253, 1),
      margin: EdgeInsets.all(0),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(19, 109, 236, 1),
                  radius: 26,
                  child: Card(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.all(
                        Radius.circular(2),
                      ),
                    ),
                    margin: EdgeInsets.all(0),
                    child: Icon(
                      Icons.bar_chart,
                      size: 18,
                      color: Color.fromRGBO(19, 109, 236, 1),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        "ATTENDANCE PERCENTAGE",
                        style: TextStyle(
                          color: Color.fromRGBO(19, 109, 236, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      attendancePercentage.when(
                        data: (data) {
                          if (data is AttendancePercentageDataState) {
                            return "${data.percentage.toInt()}%";
                          }
                          return "--";
                        },
                        error: (error, stackTrace) => "--",
                        loading: () => "--",
                      ),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                minHeight: 6,
                color: Color.fromRGBO(19, 109, 236, 1),
                value: attendancePercentage.when(
                  data: (data) {
                    if (data is AttendancePercentageDataState) {
                      return data.percentage / 100;
                    }
                    return 0;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
