import 'package:flutter/material.dart';
import 'package:staff_app/apply_od_screen.dart';

class ApplyOdWidget extends StatelessWidget {
  const ApplyOdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 0,
      color: Color.fromRGBO(255, 247, 237, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        side: BorderSide(width: 2, color: Color.fromRGBO(254, 225, 191, 1)),
      ),
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApplyOdScreen(),)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Card(
                    color: Color.fromRGBO(249, 116, 22, 1),
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
                        "Apply for OD (On Duty)",
                        style: TextStyle(
                          color: Color.fromRGBO(204, 96, 50, 1),
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Seminars, Events, or Duties",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Color.fromRGBO(204, 96, 50, 1),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.arrow_forward, color: Color.fromRGBO(249, 116, 22, 1)),
            ],
          ),
        ),
      ),
    );
  }
}
