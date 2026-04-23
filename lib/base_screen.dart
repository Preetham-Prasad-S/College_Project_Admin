import 'package:flutter/material.dart';
import 'package:staff_app/features/home/presentation/screens/home_screen.dart';
import 'package:staff_app/features/history/presentation/screens/history_screen.dart';
import 'package:staff_app/leave_screen.dart';
import 'package:staff_app/profile_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedScreen = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    HistoryScreen(),
    LeaveScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedScreen, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: BoxBorder.fromLTRB(top: BorderSide(color: Colors.black12)),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() {
            _selectedScreen = value;
          }),
          currentIndex: _selectedScreen,
          elevation: 0,
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: true,
          selectedItemColor: Color.fromRGBO(19, 109, 236, 1),
          unselectedItemColor: Color.fromRGBO(148, 163, 184, 1),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.window),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              label: "Leave",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
