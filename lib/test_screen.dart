import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/usescases/get_attendance_percentage_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_attendance_status_usecase.dart';

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

                final d = HomeDatasourceImpl(
                  firebaseInstance: FirebaseFirestore.instance,
                );

                final r = HomeRepositoryImpl(
                  dataSource: d,
                  locationService: GeolocatorService(),
                );

                final u = GetStaffAttendanceStatusUsecase(repository: r);

                final u2 = r.setStaffStatus(StaffAttendanceEntry(entry: DateTime.now(), type: "", isLateEntry: isLateEntry, isLateExit: isLateExit))

                final result = await u(
                  GetStaffAttendanceStatusUsecaseParams(
                    currentTime: DateTime.now(),
                  ),
                );

                result.fold((l) => print(l), (r) => print(r));
              },

              child: Text("Get Working Days"),
            ),
          ],
        ),
      ),
    );
  }
}
