import 'package:geolocator/geolocator.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/core/services/service.dart';

class GeolocatorService implements LocationService {
  @override
  Stream<Position> getCurrentLocation() async* {
    await getLocationPermission();

    yield* Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  @override
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
