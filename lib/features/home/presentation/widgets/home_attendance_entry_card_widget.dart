import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/presentation/controllers/states/location_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_shift_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_status_state.dart';
import 'package:staff_app/features/home/presentation/widgets/attendance_entry_buttons_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/in_premises_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/live_clock_widget.dart';

class HomeAttendanceEntryCardWidget extends ConsumerWidget {
  const HomeAttendanceEntryCardWidget({super.key});

  String currentDate() {
    return DateFormat("EEE, dd MMM yyyy").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(staffLocationControllerProvider);
    final staffShiftState = ref.watch(getStaffShiftControllerProvider);
    final staffAttendanceStatusState = ref.watch(
      staffAttendanceStatusControllerProvider,
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(20, 106, 234, 1),
            Color.fromARGB(255, 28, 78, 217),
          ],
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(19, 109, 236, 0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            Text(
              currentDate(),
              style: TextStyle(color: Colors.white, height: 1),
            ),
            const LiveClock(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: SizedBox(
                width: 200,
                child: staffAttendanceStatusState.when(
                  data: (data) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: data is StaffStatusClockedInState
                                ? Color.fromRGBO(99, 255, 156, 1)
                                : const Color.fromRGBO(255, 178, 34, 1),
                          ),
                          height: 10,
                          width: 10,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          data is StaffStatusClockedInState
                              ? "Currently Clocked In"
                              : data is StaffStatusClockedOutState
                              ? "Currently Clocked Out"
                              : "Session Completed",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: const Color.fromARGB(255, 255, 56, 34),
                        ),
                        height: 10,
                        width: 10,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Error In Fetching Data",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  loading: () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: const Color.fromRGBO(255, 178, 34, 1),
                        ),
                        height: 10,
                        width: 10,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Fetching Data",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 80,
              child: locationState.when(
                data: (location) {
                  if (location is LocationDataState) {
                    if (location.inCampus) {
                      return staffAttendanceStatusState.when(
                        data: (data) {
                          if (data is StaffStatusClockedInState) {
                            return AttendanceEntryButtonsWidget(
                              clockedInstate: false,
                              clockedOutstate: true,
                            );
                          } else if (data is StaffStatusClockedOutState) {
                            return AttendanceEntryButtonsWidget(
                              clockedInstate: true,
                              clockedOutstate: false,
                            );
                          }
                          return AttendanceEntryButtonsWidget(
                            clockedInstate: false,
                            clockedOutstate: false,
                          );
                        },
                        error: (error, stackTrace) =>
                            AttendanceEntryButtonsWidget(
                              clockedInstate: false,
                              clockedOutstate: false,
                            ),
                        loading: () => AttendanceEntryButtonsWidget(
                          clockedInstate: false,
                          clockedOutstate: false,
                        ),
                      );
                    }
                    return AttendanceEntryButtonsWidget(
                      clockedInstate: false,
                      clockedOutstate: false,
                    );
                  }
                  return AttendanceEntryButtonsWidget(
                    clockedInstate: false,
                    clockedOutstate: false,
                  );
                },
                error: (error, stackTrace) => AttendanceEntryButtonsWidget(
                  clockedInstate: false,
                  clockedOutstate: false,
                ),
                loading: () => AttendanceEntryButtonsWidget(
                  clockedInstate: false,
                  clockedOutstate: false,
                ),
              ),
            ),
            SizedBox(height: 10),

            staffShiftState.when(
              data: (data) => Text(
                "Shift : ${data is StaffShiftDataState ? DateFormat("hh:mm a").format((data.endShift)) : "--:--:--"}  - ${data is StaffShiftDataState ? DateFormat("hh:mm a").format((data.startShift)) : "--:--:--"} ",
                style: TextStyle(
                  height: 2,
                  color: const Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
              error: (error, stackTrace) => Text(
                "Failed To Obtain Shift Details",
                style: TextStyle(
                  height: 2,
                  color: const Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
              loading: () => Text(
                "Getting Shift Details",
                style: TextStyle(
                  height: 2,
                  color: const Color.fromRGBO(255, 255, 255, 0.7),
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: locationState.when(
                data: (data) {
                  data as LocationDataState;

                  return InPremisesWidget(
                    state: data.inCampus ? "true" : "false",
                  );
                },
                error: (error, stackTrace) => InPremisesWidget(state: "error"),
                loading: () => InPremisesWidget(state: "loading"),
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
