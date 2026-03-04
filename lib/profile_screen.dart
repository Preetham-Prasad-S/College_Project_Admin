import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staff_app/base_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromRGBO(244, 248, 254, 1),
            const Color.fromARGB(255, 255, 255, 255),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          actionsPadding: EdgeInsets.only(right: 20),
          title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit, color: const Color.fromRGBO(0, 0, 0, 1)),
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 40),
                  Card(
                    elevation: 10,
                    shadowColor: Colors.black54,
                    shape: CircleBorder(),
                    margin: EdgeInsets.all(0),
                    child: Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: const CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          "https://img.freepik.com/premium-vector/vector-illustration-man-cartoon-character_1234575-314.jpg",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Preetham Prasad S",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    color: Color.fromRGBO(229, 239, 252, 1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "STAFF ID: JITCSE255",
                        style: TextStyle(
                          color: Color.fromRGBO(19, 109, 236, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 45),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "PERSONAL INFORMATION",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(19, 109, 236, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Color.fromRGBO(237, 241, 245, 1)),
                    ),
                    elevation: 0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Card(
                                color: Color.fromRGBO(231, 240, 253, 1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                margin: EdgeInsets.all(0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.mail,
                                    color: Color.fromRGBO(19, 109, 236, 1),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email Address",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(19, 109, 236, 1),
                                    ),
                                  ),
                                  Text(
                                    "example123456@gmail.com",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0,
                          ),
                          child: Divider(
                            color: Color.fromRGBO(237, 241, 245, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Card(
                                color: Color.fromRGBO(231, 240, 253, 1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                margin: EdgeInsets.all(0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.apartment_rounded,
                                    color: Color.fromRGBO(19, 109, 236, 1),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Department",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(19, 109, 236, 1),
                                    ),
                                  ),
                                  Text(
                                    "Computer Science",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Divider(
                            color: Color.fromRGBO(237, 241, 245, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Card(
                                color: Color.fromRGBO(231, 240, 253, 1),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                margin: EdgeInsets.all(0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.badge_rounded,
                                    color: Color.fromRGBO(19, 109, 236, 1),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Designation",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(19, 109, 236, 1),
                                    ),
                                  ),
                                  Text(
                                    "Senior Lecturer",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "ACCOUNT SETTINGS",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(19, 109, 236, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(color: Color.fromRGBO(237, 241, 245, 1)),
                    ),
                    elevation: 0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    child: Column(
                      children: [
                        SizedBox(height: 5),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    color: Color.fromRGBO(231, 240, 253, 1),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.all(0),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.lock,
                                        color: Color.fromRGBO(19, 109, 236, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color.fromRGBO(164, 199, 247, 1),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0,
                          ),
                          child: Divider(
                            color: Color.fromRGBO(237, 241, 245, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    color: Color.fromRGBO(231, 240, 253, 1),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.all(0),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.notifications,
                                        color: Color.fromRGBO(19, 109, 236, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Notification Settings",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color.fromRGBO(164, 199, 247, 1),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 0,
                          ),
                          child: Divider(
                            color: Color.fromRGBO(237, 241, 245, 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Card(
                                    color: Color.fromRGBO(231, 240, 253, 1),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.all(0),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.shield,
                                        color: Color.fromRGBO(19, 109, 236, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Privacy & Security",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                color: Color.fromRGBO(164, 199, 247, 1),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      elevation: WidgetStatePropertyAll(0),
                      fixedSize: WidgetStatePropertyAll(
                        Size(double.infinity, 60),
                      ),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          side: BorderSide(
                            color: Color.fromRGBO(249, 220, 220, 1),
                          ),
                          borderRadius: BorderRadiusGeometry.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    onPressed: logout,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: Color.fromARGB(255, 239, 69, 69),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 239, 69, 69),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "App Version 0.0.0 (Staff Edition)",
                    style: TextStyle(
                      color: Color.fromARGB(255, 168, 201, 248),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
