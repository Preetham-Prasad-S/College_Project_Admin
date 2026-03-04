class CollegeLocationModel {
  final double longitude;
  final double latitude;

  CollegeLocationModel({required this.longitude, required this.latitude});

  factory CollegeLocationModel.fromJson(Map<String, dynamic> json) {
    return CollegeLocationModel(
      longitude: json["longitude"],
      latitude: json["latitude"],
    );
  }

  @override
  String toString() {
    return "CollegeLocationModel(longitude : $longitude, latitude : $latitude)";
  }
}
