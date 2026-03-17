import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/features/home/dependency.dart';

class AttendanceEntryButtonsWidget extends ConsumerWidget {
  final bool clockedInstate;
  final bool clockedOutstate;

  const AttendanceEntryButtonsWidget({
    super.key,
    required this.clockedInstate,
    required this.clockedOutstate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
     final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: clockedInstate
                        ? const Color.fromRGBO(0, 0, 0, 0)
                        : Color.fromRGBO(255, 255, 255, 0.2),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  clockedInstate
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(255, 255, 255, 0.1),
                ),
                elevation: WidgetStatePropertyAll(0),
                minimumSize: WidgetStatePropertyAll(Size(0, 60)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                  ),
                ),
              ),
              onPressed: () {
                if (clockedInstate) {
                  ref
                      .read(staffAttendanceStatusControllerProvider.notifier)
                      .attendancEntry("clock_in");
                  ref.refresh(staffAttendanceStatusControllerProvider);
                  ref.refresh(attendancePercentageControllerProvider);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    size: width>360 ? 20 : 17,
                    color: clockedInstate
                        ? Color.fromRGBO(19, 109, 236, 1)
                        : Color.fromRGBO(255, 255, 255, 0.3),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Clock In",
                    style: TextStyle(
                      fontSize: width>360 ? 16 : 13,
                      color: clockedInstate
                          ? Color.fromRGBO(19, 109, 236, 1)
                          : Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
      
          const SizedBox(width: 15),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: clockedOutstate
                        ? const Color.fromRGBO(0, 0, 0, 0)
                        : Color.fromRGBO(255, 255, 255, 0.2),
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  clockedOutstate
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : Color.fromRGBO(255, 255, 255, 0.1),
                ),
                elevation: WidgetStatePropertyAll(0),
                minimumSize: WidgetStatePropertyAll(Size(0, 60)),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
                  ),
                ),
              ),
              onPressed: () {
                if (clockedOutstate) {
                  ref
                      .read(staffAttendanceStatusControllerProvider.notifier)
                      .attendancEntry("clock_out");
                  ref.refresh(staffAttendanceStatusControllerProvider);
                  ref.refresh(attendancePercentageControllerProvider);
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login,
                    size: width>360 ? 20 : 17,
                    color: clockedOutstate
                        ? const Color.fromARGB(255, 255, 55, 41)
                        : Color.fromRGBO(255, 255, 255, 0.3),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Clock Out",
                    style: TextStyle(
                      fontSize: width>360 ? 16 : 13,
                      color: clockedOutstate
                          ? const Color.fromARGB(255, 255, 55, 41)
                          : Color.fromRGBO(255, 255, 255, 0.3),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
