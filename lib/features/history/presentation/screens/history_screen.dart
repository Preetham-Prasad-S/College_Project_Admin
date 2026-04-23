import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staff_app/base_screen.dart';
import 'package:staff_app/features/history/presentation/widgets/daily_history_widget.dart';
import 'package:staff_app/features/history/presentation/widgets/history_appbar_widget.dart';
import 'package:staff_app/features/history/presentation/widgets/total_hours_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int totalWorkingDays = 0;
  int totalPresentDays = 0;
  int totalWorkingHours = 0;
  int totalWorkingMinutes = 0;
  String _selectedMonth = DateFormat("MMM").format(DateTime.now());
  String _selectedYear = DateFormat("yyyy").format(DateTime.now());
  List<Map<String, dynamic>> historyData = []; // Fixed: empty list, not null
  bool isLoading = false;
  String? errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        toolbarHeight: 100,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 35),
          child: HistoryAppBar(
            onFilter: () {},
            selectedMonth: _selectedMonth,
            selectedYear: _selectedYear,
          ),
        ),
        title: Text("History", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.file_download_outlined,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => BaseScreen()),
            ),
            icon: Icon(
              Icons.arrow_back,
              color: const Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              TotalHoursWidget(
                totalWorkingDays: totalWorkingDays.toString(),
                totalPresentDays: historyData.length.toString(),
                hours: totalWorkingHours.toString(),
                minutes: totalWorkingMinutes.toString(),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$_selectedMonth $_selectedYear",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    fontSize: 16,
                    color: Color.fromRGBO(164, 171, 182, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              DailyHistoryWidget(dates: historyData, month: _selectedMonth),
            ],
          ),
        ),
      ),
    );
  }
}
