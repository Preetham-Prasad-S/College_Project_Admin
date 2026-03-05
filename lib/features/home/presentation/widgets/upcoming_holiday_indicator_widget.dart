import 'package:flutter/material.dart';

class UpcomingHolidayIndicatorWidget extends StatelessWidget {
  const UpcomingHolidayIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        const Card(
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
                        padding: EdgeInsets.symmetric(
                          vertical: 13,
                          horizontal: 12,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "OCT",
                              style: TextStyle(
                                color: Color.fromRGBO(19, 109, 236, 1),
                                fontSize: 14,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "14",
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
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Gandhi Jayanthi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Public Holiday • Monday",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
        ),
        const SizedBox(height: 12),
        const Card(
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
                      color: Color.fromRGBO(235, 239, 243, 1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              "DEC",
                              style: TextStyle(
                                color: Color.fromRGBO(120, 134, 154, 1),
                                fontSize: 14,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "25",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromRGBO(120, 134, 154, 1),
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chistmas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          "Public Holiday • Monday",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
