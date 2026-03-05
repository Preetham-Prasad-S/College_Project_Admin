import 'package:flutter/material.dart';

class AttendanceDetailsWidget extends StatelessWidget {
  const AttendanceDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              side: BorderSide(
                width: 2,
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: CircleBorder(),
                  elevation: 0,
                  color: Color.fromRGBO(237, 252, 242, 1),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      elevation: 0,
                      color: Color.fromRGBO(22, 163, 74, 1),
                      shape: CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                Text(
                  "18",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "PRESENT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Color.fromRGBO(146, 156, 173, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              side: BorderSide(
                width: 2,
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            color: Colors.white,
            elevation: 0,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: CircleBorder(),
                  elevation: 0,
                  color: Color.fromRGBO(254, 242, 242, 1),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      elevation: 0,
                      color: Color.fromRGBO(220, 38, 38, 1),
                      shape: CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.close,
                          size: 15,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                Text(
                  "01",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "ABSENT",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Color.fromRGBO(146, 156, 173, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.all(Radius.circular(10)),
              side: BorderSide(
                width: 2,
                color: Color.fromRGBO(240, 240, 240, 1),
              ),
            ),
            color: Color.fromRGBO(255, 255, 255, 1),
            elevation: 0,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: CircleBorder(),
                  elevation: 0,
                  color: Color.fromRGBO(255, 247, 237, 1),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.all(0),
                      elevation: 0,
                      color: Color.fromRGBO(234, 90, 12, 1),
                      shape: CircleBorder(),
                      child: Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Icon(
                          Icons.check,
                          size: 15,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                ),

                Text(
                  "02",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Text(
                  "LATE",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Color.fromRGBO(146, 156, 173, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
