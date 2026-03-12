import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/attendance.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/usescases/get_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/get_working_days_usecase.dart';
import 'package:staff_app/features/home/domain/usescases/set_staff_attendance_status_usecase.dart';
import 'package:staff_app/features/home/presentation/controllers/staff_attendance_status_controller.dart';
import 'package:staff_app/features/home/presentation/controllers/states/location_state.dart';
import 'package:staff_app/features/home/presentation/controllers/states/staff_status_state.dart';

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
                final usecase = ref.watch(getWorkingDaysUsecaseProvider);
                final result = await usecase(
                  GetWorkingDaysParams(currentDate: DateTime.now()),
                );

                result.fold((l) => print(l), (r) => print(r.workingDays));

                // final homeRepository = await HomeRepositoryImpl(
                //   dataSource: HomeDatasourceImpl(
                //     firebaseInstance: FirebaseFirestore.instance,
                //   ),
                //   locationService: GeolocatorService(),
                // ).getWorkingDays(DateTime.now());

                // homeRepository.fold(
                //   (l) => print(l),
                //   (r) => print(r.workingDays),
                // );
              },

              child: Text("Get Working Days"),
            ),
          ],
        ),
      ),
    );
  }
}
