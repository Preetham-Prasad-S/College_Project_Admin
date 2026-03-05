import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/features/home/dependency.dart';

class HomeAttendanceEntryCardWidget extends ConsumerWidget {
  const HomeAttendanceEntryCardWidget({super.key});

  String currentDate() {
    return DateFormat("EEE, dd MMM yyyy").format(DateTime.now());
  }

  String currentTime() {
    return DateFormat("hh:mm a").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceCardState = ref.watch(attendanceEntryControllerProvider);

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
            Text(
              currentTime(),
              style: TextStyle(
                height: 1.2,
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: SizedBox(
                width: 200,
                child: Row(
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
                    attendanceCardState.when(
                      data: (data) => Text(
                        data.value!.isClockedIn
                            ? "Currently Clocked In"
                            : "Currently Clocked Out",
                        style: TextStyle(color: Colors.white),
                      ),
                      error: (error, stackTrace) => Text("error"),
                      loading: () => Text(
                        "Fetching Date",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: true
                              ? const Color.fromRGBO(0, 0, 0, 0)
                              : Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        true
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(255, 255, 255, 0.1),
                      ),
                      elevation: WidgetStatePropertyAll(0),
                      fixedSize: WidgetStatePropertyAll(Size(150, 60)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          size: 20,
                          color: true
                              ? Color.fromRGBO(19, 109, 236, 1)
                              : Color.fromRGBO(255, 255, 255, 0.3),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Clock In",
                          style: TextStyle(
                            fontSize: 16,
                            color: true
                                ? Color.fromRGBO(19, 109, 236, 1)
                                : Color.fromRGBO(255, 255, 255, 0.3),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),
                  ElevatedButton(
                    style: ButtonStyle(
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: true
                              ? const Color.fromRGBO(0, 0, 0, 0)
                              : Color.fromRGBO(255, 255, 255, 0.2),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        true
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : Color.fromRGBO(255, 255, 255, 0.1),
                      ),
                      elevation: WidgetStatePropertyAll(0),
                      fixedSize: WidgetStatePropertyAll(Size(150, 60)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          size: 20,
                          color: true
                              ? Color.fromRGBO(236, 19, 19, 1)
                              : Color.fromRGBO(255, 255, 255, 0.3),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Clock Out",
                          style: TextStyle(
                            fontSize: 16,
                            color: true
                                ? Color.fromRGBO(236, 19, 19, 1)
                                : Color.fromRGBO(255, 255, 255, 0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Shift",
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 0.75),
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: true
                          ? Color.fromRGBO(99, 255, 156, 1)
                          : const Color.fromARGB(255, 255, 55, 41),

                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 10,
                    width: 10,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    // inCollege
                    true
                        ? "INSIDE CAMPUS ONLY (GEOFENCED)"
                        : "NOT IN COLLEGE PREMISE",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
