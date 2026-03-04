import 'package:geolocator/geolocator.dart';
import 'package:staff_app/features/home/data/models/college_location_model.dart';

class CollegeLocation {
  final double longitude;
  final double latitude;

  CollegeLocation({required this.longitude, required this.latitude});

  factory CollegeLocation.fromModel(CollegeLocationModel model) {
    return CollegeLocation(
      longitude: model.longitude,
      latitude: model.latitude,
    );
  }

  factory CollegeLocation.fromService(Position service) {
    return CollegeLocation(
      longitude: service.longitude,
      latitude: service.latitude,
    );
  }

  @override
  String toString() {
    return "CollegeLocation(longitude : $longitude, latitude : $latitude)";
  }
}
