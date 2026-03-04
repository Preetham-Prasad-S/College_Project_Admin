import 'package:staff_app/features/home/domain/entities/college_location.dart';

abstract interface class LocationService {
  Future<Stream<CollegeLocation>> getCurrentLocation();
  Future<void> getLocationPermission();
}
