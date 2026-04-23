import 'package:flutter/material.dart';

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
