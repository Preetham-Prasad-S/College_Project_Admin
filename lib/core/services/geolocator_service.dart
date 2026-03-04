import 'package:geolocator/geolocator.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/core/services/service.dart';

class GeolocatorService {
  Future<Stream<Position>> getCurrentLocation() async {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  Future<void> getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw DeviceExcepiton(message: "GPS Permission Denied");
    }
  }
}
