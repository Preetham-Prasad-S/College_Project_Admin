import 'package:flutter/material.dart';

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
