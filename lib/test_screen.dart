import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/features/auth/data/datasource/auth_datasource_impl.dart';
import 'package:staff_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:staff_app/features/auth/domain/enitites/auth_staff.dart';
import 'package:staff_app/features/history/data/datasources/history_datasource_impl.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/models/staff_history_data_model.dart';
import 'package:staff_app/features/home/data/models/staff_monthly_history_model.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:staff_app/features/home/domain/entities/staff_attendance_entry.dart';
import 'package:staff_app/features/home/domain/usescases/get_attendance_details_usecase.dart';
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
                final d = HistoryDatasourceImpl(
                  firebaseAuth: FirebaseAuth.instance,
                  firebaseFirestore: FirebaseFirestore.instance,
                );

                final result = await d.getMonthHistory(DateTime.now());

                print(result);
              },
              child: Text("Get Working Days"),
            ),
          ],
        ),
      ),
    );
  }
}
