import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:staff_app/core/services/geolocator_service.dart';
import 'package:staff_app/core/services/service.dart';

final firebaseStoreageInstanceProvider = Provider<FirebaseFirestore>(
  (ref) => FirebaseFirestore.instance,
);

final firebaseAuthInstanceProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);
final geolocatorServiceProivder = Provider<LocationService>(
  (ref) => GeolocatorService(),
);
