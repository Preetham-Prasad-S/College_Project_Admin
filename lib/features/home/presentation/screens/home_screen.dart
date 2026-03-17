import 'package:flutter/material.dart';
import 'package:staff_app/features/home/presentation/widgets/apply_od_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/apply_leave_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/attendance_details_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/home_app_bar_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/home_attendance_entry_card_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/monthly_attendance_percentage_widget.dart';
import 'package:staff_app/features/home/presentation/widgets/upcoming_holiday_indicator_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(height: 70),
              HomeAppBarWidget(),
              const SizedBox(height: 30),
              const HomeAttendanceEntryCardWidget(),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Attendance This Month",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: Color.fromRGBO(19, 109, 236, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MonthlyAttendancePercentageWidget(),
              const SizedBox(height: 10),
              const SizedBox(height: 150, child: AttendanceDetailsWidget()),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Upcoming Holidays",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              UpcomingHolidayIndicatorWidget(),
              ApplyLeaveWidget(),
              const SizedBox(height: 12),
              ApplyOdWidget(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
