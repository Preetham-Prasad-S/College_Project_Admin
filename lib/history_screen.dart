import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:staff_app/base_screen.dart';

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

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<double> _getWorkingHours() async {
    final data = await _getHistory(_selectedYear, _selectedMonth);

    if (data == null) {
      return 0.0;
    }

    final totalWorkingHours = data
        .where((element) => element["duration"] != null)
        .fold(
          0.0,
          (addition, element) => addition + (element["duration"] as num),
        )
        .toDouble();
    return (totalWorkingHours);
  }

  Future<DateTime?> _pickPeriod() async {
    final DateTime? selected = await showMonthPicker(
      monthPickerDialogSettings: MonthPickerDialogSettings(
        dialogSettings: PickerDialogSettings(
          dialogRoundedCornersRadius: 20,
          dismissible: true,
        ),
        headerSettings: PickerHeaderSettings(
          headerBackgroundColor: Color.fromRGBO(19, 109, 236, 1),
        ),
        dateButtonsSettings: PickerDateButtonsSettings(),
      ),

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    return selected;
  }

  Future<List<Map<String, dynamic>>?> _getHistory(
    String year,
    String month,
  ) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final data = doc.data();
      if (data == null || !data.containsKey('staff_history')) {
        print("No staff history found");
        return null;
      }

      final staffHistory = data['staff_history'] as Map<String, dynamic>?;
      if (staffHistory == null || !staffHistory.containsKey(year)) {
        print("No data for year: $year");

        return null;
      }

      final yearData = staffHistory[year] as Map<String, dynamic>?;
      if (yearData == null || !yearData.containsKey(month)) {
        print("No data for $month $year");

        return null;
      }

      final List<dynamic> monthData = yearData[month];

      return monthData.whereType<Map<String, dynamic>>().toList();
    } catch (e) {
      print('Error fetching history: $e');
      return null;
    }
  }

  Future<int> _getWorkingDays() async {
    final doc = await FirebaseFirestore.instance
        .collection("history")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (!doc.exists) {
      return 0;
    }

    final data = doc.data();

    if (data == null || !data.containsKey("working_days")) {
      return 0;
    }

    final Map<String, dynamic> workingData = data["working_days"];

    if (!workingData.containsKey(_selectedYear)) {
      return 0;
    }

    final workingDays = workingData[_selectedYear][_selectedMonth];

    return workingDays ?? 0;
  }

  Future<void> onFilterPressed() async {
    final date = await _pickPeriod();
    if (date == null) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
      _selectedMonth = DateFormat("MMM").format(date);
      _selectedYear = DateFormat("yyyy").format(date);
    });

    final totalHours = await _getWorkingHours();

    final history = await _getHistory(_selectedYear, _selectedMonth);

    final workingDays = await _getWorkingDays();

    setState(() {
      totalWorkingDays = workingDays;
      totalPresentDays = totalWorkingHours = totalHours.floor();
      totalWorkingMinutes = ((totalHours % 1) * 60).round();
      isLoading = false;
      historyData = history ?? [];
      errorMessage = history == null
          ? "No Data Found for $_selectedMonth"
          : null;
    });
  }

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
            onFilter: onFilterPressed,
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

class DailyHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> dates;
  final String month;
  const DailyHistoryWidget({
    super.key,
    required this.dates,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return dates.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: dates.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Card(
                  elevation: 0,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(240, 240, 240, 1),
                    ),
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
                              color: Color.fromRGBO(243, 244, 245, 1),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 13,
                                  horizontal: 12,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      month,
                                      style: TextStyle(
                                        color: Color.fromRGBO(156, 163, 175, 1),
                                        fontSize: 14,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${dates[index]["date"]}",
                                      style: TextStyle(
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
                              children: [
                                Text(
                                  "${dates[index]["shift_start"]} - ${dates[index]["shift_end"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${dates[index]["punch_in_type"]} Check-in",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(124, 133, 147, 1),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Card(
                              color: Color.fromRGBO(220, 252, 231, 1),
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  dates[index]["status"],
                                  style: TextStyle(
                                    color: Color.fromRGBO(21, 128, 60, 1),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              dates[index]["shift_hour"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text(
              "No Records",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
          );
  }
}

class TotalHoursWidget extends StatelessWidget {
  final String hours;
  final String minutes;
  final String totalWorkingDays;
  final String totalPresentDays;
  const TotalHoursWidget({
    super.key,
    required this.hours,
    required this.minutes,
    required this.totalWorkingDays,
    required this.totalPresentDays,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            elevation: 10,
            shadowColor: Color.fromRGBO(0, 106, 255, 0.207),
            color: Color.fromRGBO(19, 109, 236, 1),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "TOTAL HOURS",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                    ),
                  ),
                  Text(
                    "$hours h $minutes m",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromRGBO(227, 228, 231, 1)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            elevation: 0,
            shadowColor: Color.fromRGBO(0, 106, 255, 0.207),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DAYS PRESENT",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                  Text(
                    "$totalPresentDays/$totalWorkingDays",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryAppBar extends StatelessWidget {
  final String selectedMonth;
  final String selectedYear;
  final VoidCallback onFilter;

  const HistoryAppBar({
    super.key,
    required this.selectedMonth,
    required this.selectedYear,
    required this.onFilter,
  });

  // Month And Year Picker
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
          child: Row(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll(8),

                  shadowColor: WidgetStatePropertyAll(
                    Color.fromRGBO(0, 106, 255, 0.207),
                  ),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(255, 255, 255, 1),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(19, 109, 236, 1),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                onPressed: onFilter,
                child: Row(
                  children: [
                    Text("$selectedMonth  $selectedYear"),
                    SizedBox(width: 10),
                    Icon(Icons.keyboard_arrow_down_rounded),
                  ],
                ),
              ),
              SizedBox(width: 10),

              // ElevatedButton(
              //   style: const ButtonStyle(
              //     side: WidgetStatePropertyAll(
              //       BorderSide(color: Color.fromRGBO(239, 240, 243, 1)),
              //     ),
              //     elevation: WidgetStatePropertyAll(.5),
              //     overlayColor: WidgetStatePropertyAll(
              //       Colors.transparent,
              //     ),
              //     shadowColor: WidgetStatePropertyAll(
              //       Color.fromRGBO(208, 227, 251, 1),
              //     ),
              //     textStyle: WidgetStatePropertyAll(
              //       TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              //     ),
              //     foregroundColor: WidgetStatePropertyAll(
              //       Color.fromRGBO(0, 0, 0, 1),
              //     ),
              //     backgroundColor: WidgetStatePropertyAll(Colors.white),
              //     shape: WidgetStatePropertyAll(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(10)),
              //       ),
              //     ),
              //   ),
              //   onPressed: () {},
              //   child: Row(
              //     children: [
              //       Text("2023"),
              //       SizedBox(width: 10),
              //       Icon(Icons.keyboard_arrow_down_rounded),
              //     ],
              //   ),
              // ),
              // SizedBox(width: 10),
              ElevatedButton(
                style: const ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(color: Color.fromRGBO(239, 240, 243, 1)),
                  ),
                  elevation: WidgetStatePropertyAll(.5),
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  shadowColor: WidgetStatePropertyAll(
                    Color.fromRGBO(208, 227, 251, 1),
                  ),
                  textStyle: WidgetStatePropertyAll(
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  foregroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(0, 0, 0, 1),
                  ),
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Icon(Icons.filter_list_rounded, size: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
