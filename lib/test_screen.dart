import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';

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
                // await HomeDatasourceImpl(
                //   firebaseInstance: FirebaseFirestore.instance,
                // ).setCurrentMonthHistory(
                //   year: 2026,
                //   month: 3,
                //   model: StaffMonthlyHistoryModel(
                //     historyData: {
                //       19: StaffHistoryDataModel(
                //         clockIn: DateTime.now(),
                //         clockOut: DateTime.now(),
                //         lateEntry: false,
                //         lateExit: false,
                //         status: "clock_in",
                //       ),
                //     },
                //   ),
                // );

                // final d = await HomeDatasourceImpl(
                //   firebaseInstance: FirebaseFirestore.instance,
                // ).getCurrentMonthHistory(DateTime.now());

                final d = await HomeDatasourceImpl(
                  firebaseInstance: FirebaseFirestore.instance,
                ).getStaffShift();

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
