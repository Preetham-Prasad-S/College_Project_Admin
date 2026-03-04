import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource_impl.dart';
import 'package:staff_app/features/home/data/repositories/home_repository_impl.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final r = HomeRepositoryImpl(
              dataSource: HomeDatasourceImpl(
                firebaseInstance: FirebaseFirestore.instance,
              ),
              locationService: GeolocatorService(),
            );

            r.getStaffShift();
          },
          child: StreamBuilder(
            stream: HomeRepositoryImpl(
              dataSource: HomeDatasourceImpl(
                firebaseInstance: FirebaseFirestore.instance,
              ),
              locationService: GeolocatorService(),
            ).currentLocation(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (asyncSnapshot.hasError) {
                return Text("Error: ${asyncSnapshot.error}");
              }

              if (!asyncSnapshot.hasData) {
                return const Text("No data");
              }

              final position = asyncSnapshot.data!;

              return Text(
                "${position.fold((l) => l.message, (r) => r.latitude)}",
              );
            },
          ),
        ),
      ),
    );
  }
}
