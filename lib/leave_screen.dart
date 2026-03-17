import 'package:flutter/material.dart';
import 'package:staff_app/base_screen.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 20),
        title: Text(
          "Leave Management",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Leave Balance",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    margin: EdgeInsets.all(0),
                    color: Color.fromRGBO(223, 232, 246, 1),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "2024 Cycle",
                        style: TextStyle(
                          color: Color.fromRGBO(19, 109, 236, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: Color.fromRGBO(239, 240, 243, 1),
                    width: 2,
                  ),
                ),
                elevation: 0,
                color: Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            elevation: 0,
                            color: Color.fromRGBO(223, 232, 246, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            margin: EdgeInsets.all(0),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.calendar_today_rounded,
                                size: 25,
                                color: Color.fromRGBO(19, 109, 236, 1),
                              ),
                            ),
                          ),
                          Text(
                            "5/10 Days",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Causal Leave",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.5,
                              color: Color.fromRGBO(71, 85, 105, 1),
                            ),
                          ),
                          SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.5,
                            minHeight: 10,
                            color: Color.fromRGBO(19, 109, 236, 1),
                            backgroundColor: Color.fromRGBO(230, 234, 237, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Color.fromRGBO(239, 240, 243, 1),
                          width: 2,
                        ),
                      ),
                      elevation: 0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Color.fromRGBO(236, 253, 245, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  margin: EdgeInsets.all(0),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.medical_services_rounded,
                                      size: 25,
                                      color: Color.fromRGBO(5, 150, 104, 1),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "8/10 Days",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sick Leave",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.5,
                                    color: Color.fromRGBO(71, 85, 105, 1),
                                  ),
                                ),
                                SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: 0.8,
                                  minHeight: 10,
                                  color: Color.fromRGBO(5, 150, 104, 1),
                                  backgroundColor: Color.fromRGBO(
                                    230,
                                    234,
                                    237,
                                    1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ],
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                          color: Color.fromRGBO(239, 240, 243, 1),
                          width: 2,
                        ),
                      ),
                      elevation: 0,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      margin: EdgeInsets.all(0),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Color.fromARGB(255, 255, 247, 237),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  margin: EdgeInsets.all(0),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.work_history_rounded,
                                      size: 25,
                                      color: Color.fromRGBO(234, 90, 12, 1),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    "5/10 Days",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Earned Leave",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.5,
                                    color: Color.fromRGBO(71, 85, 105, 1),
                                  ),
                                ),
                                SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: 0.5,
                                  minHeight: 10,
                                  color: Color.fromRGBO(234, 90, 12, 1),
                                  backgroundColor: Color.fromRGBO(
                                    230,
                                    234,
                                    237,
                                    1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Leave Balance",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  Text(
                    "View All",
                    style: TextStyle(
                      color: Color.fromRGBO(19, 109, 236, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 0,
                margin: EdgeInsets.all(0),
                color: Color.fromRGBO(230, 233, 238, 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 1,
                    horizontal: 5,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromRGBO(255, 255, 255, 1),
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text("All Requests"),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            elevation: WidgetStatePropertyAll(0),
                            backgroundColor: WidgetStatePropertyAll(
                              Color.fromRGBO(230, 233, 238, 1),
                            ),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Upcoming",
                            style: TextStyle(
                              color: Color.fromRGBO(71, 85, 105, 1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: Color.fromRGBO(228, 233, 241, 1),
                    width: 1.5,
                  ),
                ),
                elevation: 0,
                color: Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Doctor Appointment",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                "Applied on Oct 28, 2024",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(135, 149, 168, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            margin: EdgeInsets.all(0),
                            color: Color.fromRGBO(223, 232, 246, 1),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "PRESENT",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(19, 109, 236, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(color: Color.fromRGBO(135, 149, 168, 0.234)),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Color.fromRGBO(135, 149, 168, 1),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Nov 02",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 15),

                          Icon(
                            Icons.notes_rounded,
                            color: Color.fromRGBO(135, 149, 168, 1),
                          ),
                          SizedBox(width: 5),

                          Text(
                            "Sick Leave",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: Color.fromRGBO(228, 233, 241, 1),
                    width: 1.5,
                  ),
                ),
                elevation: 0,
                color: Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Annual Vaction",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                "Applied on Sep 25, 2024",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(135, 149, 168, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            margin: EdgeInsets.all(0),
                            color: Color.fromRGBO(209, 250, 229, 1),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "APPROVED",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(41, 168, 127, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(color: Color.fromRGBO(135, 149, 168, 0.234)),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Color.fromRGBO(135, 149, 168, 1),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Oct 02 - 10",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 15),

                          Icon(
                            Icons.notes_rounded,
                            color: Color.fromRGBO(135, 149, 168, 1),
                          ),
                          SizedBox(width: 5),

                          Text(
                            "Earned Leave",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(
                    color: Color.fromRGBO(228, 233, 241, 1),
                    width: 1.5,
                  ),
                ),
                elevation: 0,
                color: Color.fromRGBO(255, 255, 255, 1),
                margin: EdgeInsets.all(0),
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Family Event",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                "Applied on Dec 18, 2024",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(135, 149, 168, 1),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            margin: EdgeInsets.all(0),
                            color: Color.fromRGBO(252, 230, 230, 1),
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Text(
                                "REJECTED",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(226, 85, 85, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(color: Color.fromRGBO(135, 149, 168, 0.234)),
                      SizedBox(height: 10),

                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Color.fromRGBO(135, 149, 168, 1),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Dec 20",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 15),

                          Icon(
                            Icons.notes_rounded,
                            color: Color.fromRGBO(135, 149, 168, 1),
                          ),
                          SizedBox(width: 5),

                          Text(
                            "Casual Leave",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color.fromRGBO(19, 109, 236, 1),
        foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
    );
  }
}
