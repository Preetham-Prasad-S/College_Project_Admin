import 'package:geolocator/geolocator.dart';

class CollegeLocation {
  final double longitude;
  final double latitude;

  CollegeLocation({required this.longitude, required this.latitude});

  factory CollegeLocation.fromJson(Map<String, dynamic> json) {
    return CollegeLocation(
      longitude: json["longitude"],
      latitude: json["latitude"],
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
