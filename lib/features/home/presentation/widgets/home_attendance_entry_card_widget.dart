import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/staff_shift.dart';

class HomeAttendanceEntryCardWidget extends ConsumerStatefulWidget {
  const HomeAttendanceEntryCardWidget({super.key});

  @override
  ConsumerState<HomeAttendanceEntryCardWidget> createState() =>
      _HomeAttendanceEntryCardWidgetState();
}

class _HomeAttendanceEntryCardWidgetState
    extends ConsumerState<HomeAttendanceEntryCardWidget> {
  late Timer tick;
  AsyncValue<StaffShift>? staffShift;
  String currentTime = DateFormat("hh:mm a").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    tick = Timer.periodic(
      Duration(seconds: 1),
      (timer) => setState(() {
        currentTime = DateFormat("hh:mm a").format(DateTime.now());
      }),
    );
  }

  String currentDate() {
    return DateFormat("EEE, dd MMM yyyy").format(DateTime.now());
  }

  Future<void> loadStaffShift() async {
    final controller = ref.read(attendanceEntryControllerProvider.notifier);

    final shift = await controller.getStaffShift();

    if (mounted) {
      setState(() {
        staffShift = shift;
      });
    }
  }

  @override
  void dispose() {
    tick.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              currentTime,
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
                child: attendanceCardState.when(
                  data: (data) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color.fromRGBO(99, 255, 156, 1),
                        ),
                        height: 10,
                        width: 10,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        data.value!.isClockedIn
                            ? "Currently Clocked In"
                            : "Currently Clocked Out",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
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
              child: attendanceCardState.when(
                data: (data) => AttendanceEntryButtonsWidget(state: true),
                loading: () => AttendanceEntryButtonsWidget(state: false),
                error: (error, stackTrace) =>
                    AttendanceEntryButtonsWidget(state: false),
              ),
            ),
            SizedBox(height: 10),

            staffShift?.when(
                  data: (data) => Text("Data"),
                  error: (error, stackTrace) => Text("Error"),
                  loading: () => Text("loading"),
                ) ??
                Text("Couldn't Get Staff Shift"),

            Container(
              alignment: Alignment.center,
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: InPremisesWidget(state: 0),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class InPremisesWidget extends StatelessWidget {
  final int state;

  const InPremisesWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          "ERROR IN FETCHING LOCATION",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

class AttendanceEntryButtonsWidget extends StatelessWidget {
  final bool state;

  const AttendanceEntryButtonsWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            side: WidgetStatePropertyAll(
              BorderSide(
                color: state
                    ? const Color.fromRGBO(0, 0, 0, 0)
                    : Color.fromRGBO(255, 255, 255, 0.2),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              state
                  ? const Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(255, 255, 255, 0.1),
            ),
            elevation: WidgetStatePropertyAll(0),
            fixedSize: WidgetStatePropertyAll(Size(150, 60)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
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
                color: state
                    ? Color.fromRGBO(19, 109, 236, 1)
                    : Color.fromRGBO(255, 255, 255, 0.3),
              ),
              SizedBox(width: 10),
              Text(
                "Clock In",
                style: TextStyle(
                  fontSize: 16,
                  color: state
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
                color: state
                    ? const Color.fromRGBO(0, 0, 0, 0)
                    : Color.fromRGBO(255, 255, 255, 0.2),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              state
                  ? const Color.fromRGBO(255, 255, 255, 1)
                  : Color.fromRGBO(255, 255, 255, 0.1),
            ),
            elevation: WidgetStatePropertyAll(0),
            fixedSize: WidgetStatePropertyAll(Size(150, 60)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
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
                color: state
                    ? const Color.fromARGB(255, 255, 55, 41)
                    : Color.fromRGBO(255, 255, 255, 0.3),
              ),
              SizedBox(width: 10),
              Text(
                "Clock Out",
                style: TextStyle(
                  fontSize: 16,
                  color: state
                      ? const Color.fromARGB(255, 255, 55, 41)
                      : Color.fromRGBO(255, 255, 255, 0.3),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
