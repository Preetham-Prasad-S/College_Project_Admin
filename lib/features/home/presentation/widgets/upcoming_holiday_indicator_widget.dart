import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/presentation/controllers/states/college_holiday_state.dart';

class UpcomingHolidayIndicatorWidget extends ConsumerWidget {
  const UpcomingHolidayIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final holidayState = ref.watch(collegeHolidayControllerProvider);
    return Column(
      children: [
        const SizedBox(height: 15),
        holidayState.when(
          data: (data) {
            if (data is CollegeHolidayErrorState) {
              return const Text("No upcoming holidays");
            } else {
              data as CollegeHolidayDataState;
            }

            if (data.holidays == null) {
              return const Text("No upcoming holidays");
            }

            if (data.holidays!.holidayDates == null) {
              return const Text("No upcoming holidays");
            }

            final holidays = data.holidays!.holidayDates!;
            if (holidays.isEmpty) {
              return const Text("No upcoming holidays");
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: min(2, holidays.length),
              itemBuilder: (context, index) {
                final holiday = holidays[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: (index == 0 && holidays.length > 1) ? 12 : 0,
                  ),
                  child: HolidayCardWidget(
                    date: holiday.date,
                    holidayName: holiday.name,
                    type: holiday.type,
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return const Text("No upcoming holidays");
          },
          loading: () {
            return Container(
              height: 100,
              width: double.infinity,
              color: Colors.grey.shade200,
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

class HolidayCardWidget extends StatelessWidget {
  final DateTime date;
  final String holidayName;
  final String type;

  const HolidayCardWidget({
    super.key,
    required this.date,
    required this.holidayName,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Color.fromRGBO(255, 255, 255, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(width: 2, color: Color.fromRGBO(240, 240, 240, 1)),
      ),
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Card(
                  color: Color.fromRGBO(231, 240, 253, 1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    child: Column(
                      children: [
                        Text(
                          DateFormat('MMM').format(date).toUpperCase(),
                          style: const TextStyle(
                            color: Color.fromRGBO(19, 109, 236, 1),
                            fontSize: 14,
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat('dd').format(date),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromRGBO(19, 109, 236, 1),
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      holidayName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        // height: 0.8,
                      ),
                    ),
                    Text(
                      "$type • ${DateFormat('EEEE').format(date)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        // height: 0.01,
                        color: Color.fromRGBO(146, 156, 173, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: Color.fromRGBO(209, 218, 229, 1),
            ),
          ],
        ),
      ),
    );
  }
}
