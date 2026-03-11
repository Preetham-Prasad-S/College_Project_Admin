import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_attendance_status_usecase.dart';

class TestScreen extends ConsumerWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final a = ref.watch(attendanceEntryControllerProvider);
    final ac = ref.read(attendanceEntryControllerProvider.notifier);

    final datasources = HomeDatasourceImpl(
      firebaseInstance: FirebaseFirestore.instance,
    );

    final repo = HomeRepositoryImpl(
      dataSource: datasources,
      locationService: GeolocatorService(),
    );

    final getstaffhistoryUsecase = GetStaffAttendanceStatusUsecase(
      repository: ref.read(homeRepositoryProvider),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final u = await getstaffhistoryUsecase(
                GetStaffAttendanceStatusUsecaseParams(
                  currentTime: DateTime.now(),
                ),
              );

              u.fold((l) => print(l), (r) => print(r));

              // final data = await datasources.getStaffHistory(DateTime.now());
              // print(data);
            },
            child: Text("get history"),
          ),

          ElevatedButton(
            onPressed: () async {
              await datasources.setStaffHistory(
                StaffAttendanceEntryModel(
                  entry: DateTime.now(),
                  type: "clock_out",
                ),
              );
            },
            child: Text("set history"),
          ),
          const SizedBox(height: 20),
          Center(child: Text("DAta")),
        ],
      ),
    );
  }
}
