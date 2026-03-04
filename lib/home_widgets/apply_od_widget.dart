import 'package:flutter/material.dart';

class ApplyOdWidget extends StatelessWidget {
  const ApplyOdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 0,
      color: Color.fromRGBO(243, 248, 254, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(width: 2, color: Color.fromRGBO(215, 226, 243, 1)),
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
                  color: Color.fromRGBO(19, 109, 236, 1),
                  elevation: 0,
                  shape: CircleBorder(),
                  margin: EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    child: Icon(
                      Icons.badge,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Apply for Leave",
                      style: TextStyle(
                        color: Color.fromRGBO(19, 109, 236, 1),
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "Sick, Vacation, or Personal",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromRGBO(19, 109, 236, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(Icons.arrow_forward, color: Color.fromRGBO(19, 109, 236, 1)),
          ],
        ),
      ),
    );
  }
}
