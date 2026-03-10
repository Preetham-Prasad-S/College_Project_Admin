import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/failures.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/models/staff_history_model.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/dependency.dart';
import 'package:staff_app/features/home/domain/entities/staff_history.dart';

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

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              HomeDatasourceImpl(
                firebaseInstance: FirebaseFirestore.instance,
              ).setStaffHistory(
                StaffHistoryModel(
                  clockIn: DateTime.now(),
                  clockOut: DateTime.now(),
                ),
              );
            },
            child: Text("Press Me Hard Daddy"),
          ),
          const SizedBox(height: 20),
          Center(
            child: a.when(
              data: (data) => Text("${data.value?.inPremises}"),
              error: (error, stackTrace) => Text("$error"),
              loading: () => CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
