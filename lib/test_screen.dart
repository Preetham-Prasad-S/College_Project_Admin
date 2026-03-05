import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/core/usecases/usecase.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/domain/usescases/attendance_entry_usecase.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = HomeRepositoryImpl(
      dataSource: HomeDatasourceImpl(
        firebaseInstance: FirebaseFirestore.instance,
      ),
      locationService: GeolocatorService(),
    );

    final usecase = AttendanceEntryUsecase(repository: repository);

    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: usecase(NoParams()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return const Text("No data");
            }

            final result = snapshot.data!;

            return result.fold(
              (failure) => Text("Error: ${failure.message}"),
              (attendance) => Text(
                "In Premises: ${attendance.inPremises}\n"
                "Clocked In: ${attendance.isClockedIn}",
              ),
            );
          },
        ),
      ),
    );
  }
}
