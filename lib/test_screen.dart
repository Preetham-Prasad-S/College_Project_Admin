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
                // final d = HomeDatasourceImpl(
                //   firebaseInstance: FirebaseFirestore.instance,
                // );

                // final dresult = await d.getHolidayDays(DateTime.now());

                // print(dresult);

                final u = GetAttendancePercentageUsecase(
                  repository: ref.watch(homeRepositoryProvider),
                );

                final result = await u(
                  GetAttendancePercentageUsecaseParams(
                    currentDate: DateTime.now(),
                  ),
                );

                result.fold((l) => print(l), (r) => print(r.percentage));
              },

              child: Text("Get Working Days"),
            ),
          ],
        ),
      ),
    );
  }
}
