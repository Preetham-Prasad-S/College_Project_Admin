import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/usescases/get_attendance_percentage_usecase.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final d = await HomeDatasourceImpl(
                  firebaseInstance: FirebaseFirestore.instance,
                ).getCurrentMonthHistory(DateTime.now());

                print(d);
              },

              child: Text("Get Working Days"),
            ),
          ],
        ),
      ),
    );
  }
}
