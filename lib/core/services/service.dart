import 'package:geolocator/geolocator.dart';

abstract interface class LocationService {
  Stream<Position> getCurrentLocation();
  Future<void> getLocationPermission();
}
