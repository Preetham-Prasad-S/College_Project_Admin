import 'package:flutter/material.dart';

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
