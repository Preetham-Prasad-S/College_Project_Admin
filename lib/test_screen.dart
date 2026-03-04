import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final d = HomeDatasourceImpl(
              dataSource: FirebaseFirestore.instance,
            );

            d.getStaffStatus();
          },
          child: Text("Hello"),
        ),
      ),
    );
  }
}
