import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class HomeAttendanceEntryCardWidget extends StatefulWidget {
  const HomeAttendanceEntryCardWidget({super.key});

  @override
  State<HomeAttendanceEntryCardWidget> createState() =>
      _HomeAttendanceEntryCardWidgetState();
}

class _HomeAttendanceEntryCardWidgetState
    extends State<HomeAttendanceEntryCardWidget> {
  final StreamController<bool> _inPremisesController =
      StreamController<bool>.broadcast();
  final StreamController<String> _dateController =
      StreamController<String>.broadcast();
  final StreamController<String> _timeController =
      StreamController<String>.broadcast();

  Timer? _locationTimer;
  Timer? _timeTimer;
  bool _isCheckingLocation = false;

  Stream<bool> get inPremisesStream => _inPremisesController.stream;
  Stream<String> get dateStream => _dateController.stream;
  Stream<String> get timeStream => _timeController.stream;

  @override
  void initState() {
    super.initState();
    _startStreamMonitoring();
  }

  void _startStreamMonitoring() {
    _locationTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      _inPremises();
    });

    _timeTimer = Timer.periodic(Duration(minutes: 1), (timer) {
      _updateDateTime();
    });

    // Initial values
    _inPremises();
    _updateDateTime();
  }

  void _updateDateTime() {
    _dateController.add(_getDate());
    _timeController.add(_getTime());
  }

  @override
  void dispose() {
    _inPremisesController.close();
    _dateController.close();
    _timeController.close();
    _locationTimer?.cancel();
    _timeTimer?.cancel();
    super.dispose();
  }

  static String _getDate() {
    final now = DateTime.now();
    return DateFormat("EEEE, dd MMM yyy").format(now);
  }

  static String _getTime() {
    final now = DateTime.now();
    return DateFormat("hh:mm a").format(now);
  }

  Future<Map<String, double>?> _getCollegeLocation() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection("college")
          .doc("location_details")
          .get();

      if (doc.exists && doc.data() != null) {
        final data = Map<String, double>.from(doc.data()!["location"] as Map);
        print(data);
        return data;
      }
      return null;
    } catch (e) {
      print('College location fetch error: $e');
      return null;
    }
  }

  Future<bool> _handlePermission() async {
    // Check service
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Check permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  Future<Position?> _getCurrentLocation() async {
    try {
      bool hasPermission = await _handlePermission();
      if (!hasPermission) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 10),
      );
      return position;
    } catch (e) {
      print('Location error: $e');
      return null;
    }
  }

  Future<bool> _inPremises({double radiusMeters = 100}) async {
    try {
      // 1. Get current position (includes permission check)
      Position? currentPosition = await _getCurrentLocation();
      if (currentPosition == null) {
        print('Could not get current location');
        return false;
      }

      // 2. Get college location
      Map<String, double>? collegeLocation = await _getCollegeLocation();
      if (collegeLocation == null ||
          collegeLocation["latitude"] == null ||
          collegeLocation["longitude"] == null) {
        print(collegeLocation!["latitude"]);
        print('Invalid college location data');
        return false;
      }

      // 3. Parse college coordinates safely
      double collegeLat = collegeLocation["latitude"]!;
      double collegeLng = collegeLocation["longitude"]!;

      if (collegeLat == 0.0 || collegeLng == 0.0) {
        print('Invalid college coordinates');
        return false;
      }

      // 4. Calculate distance (FIXED: correct parameter order)
      double distance = Geolocator.distanceBetween(
        collegeLat, // College latitude
        collegeLng, // College longitude
        currentPosition.latitude, // User latitude
        currentPosition.longitude, // User longitude
      );

      print('Distance from college: ${distance.toStringAsFixed(0)}m');

      // 5. Check if within radius
      bool isInPremises = distance <= radiusMeters;

      if (mounted) {
        _inPremisesController.add(isInPremises);
      }
      return isInPremises;
    } catch (e) {
      print('In premises check failed: $e');
      return false;
    }
  }

  Future<String?> getStartShift() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("college")
          .doc("shift_details")
          .get();

      if (result.exists &&
          result.data() != null &&
          result.data()!["normal_shift"] != null &&
          result.data()!["normal_shift"]["start"] != null) {
        return await result.data()!["normal_shift"]["start"] as String;
      }
      print('Start shift data not found');
      return null;
    } catch (e) {
      print('Error fetching start shift: $e');
      return null;
    }
  }

  Future<String?> getEndShift() async {
    try {
      final result = await FirebaseFirestore.instance
          .collection("college")
          .doc("shift_details")
          .get();

      if (result.exists &&
          result.data() != null &&
          result.data()!["normal_shift"] != null &&
          result.data()!["normal_shift"]["end"] != null) {
        return result.data()!["normal_shift"]["end"] as String;
      }
      print('End shift data not found');
      return null;
    } catch (e) {
      print('Error fetching end shift: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(20, 106, 234, 1),
            Color.fromARGB(255, 28, 78, 217),
          ],
          begin: AlignmentGeometry.topLeft,
          end: AlignmentGeometry.bottomRight,
        ),
        boxShadow: [
          const BoxShadow(
            color: Color.fromRGBO(19, 109, 236, 0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),

            StreamBuilder(
              stream: dateStream,
              initialData: _getDate(),
              builder: (context, asyncSnapshot) {
                return Text(
                  asyncSnapshot.data ?? "",
                  style: TextStyle(color: Colors.white, height: 1),
                );
              },
            ),
            StreamBuilder(
              stream: timeStream,
              initialData: _getTime(),
              builder: (context, asyncSnapshot) {
                return Text(
                  asyncSnapshot.data ?? "",
                  style: TextStyle(
                    height: 1.2,
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: const Color.fromRGBO(255, 178, 34, 1),
                      ),
                      height: 10,
                      width: 10,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Currently Clocked Out",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: inPremisesStream,
                    // initialData: _inPremises(),
                    builder: (context, asyncSnapshot) {
                      final inCollege = asyncSnapshot.data ?? false;

                      return ElevatedButton(
                        style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: inCollege
                                  ? const Color.fromRGBO(0, 0, 0, 0)
                                  : Color.fromRGBO(255, 255, 255, 0.2),
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            inCollege
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                          elevation: WidgetStatePropertyAll(0),
                          fixedSize: WidgetStatePropertyAll(Size(150, 60)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.login,
                              size: 20,
                              color: inCollege
                                  ? Color.fromRGBO(19, 109, 236, 1)
                                  : Color.fromRGBO(255, 255, 255, 0.3),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Clock In",
                              style: TextStyle(
                                fontSize: 16,
                                color: inCollege
                                    ? Color.fromRGBO(19, 109, 236, 1)
                                    : Color.fromRGBO(255, 255, 255, 0.3),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 15),
                  StreamBuilder(
                    stream: inPremisesStream,
                    // initialData: _inPremises(),
                    builder: (context, asyncSnapshot) {
                      final inCollege = asyncSnapshot.data ?? false;

                      return ElevatedButton(
                        style: ButtonStyle(
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: inCollege
                                  ? const Color.fromRGBO(0, 0, 0, 0)
                                  : Color.fromRGBO(255, 255, 255, 0.2),
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            inCollege
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : Color.fromRGBO(255, 255, 255, 0.1),
                          ),
                          elevation: WidgetStatePropertyAll(0),
                          fixedSize: WidgetStatePropertyAll(Size(150, 60)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.login,
                              size: 20,
                              color: inCollege
                                  ? Color.fromRGBO(236, 19, 19, 1)
                                  : Color.fromRGBO(255, 255, 255, 0.3),
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Clock Out",
                              style: TextStyle(
                                fontSize: 16,
                                color: inCollege
                                    ? Color.fromRGBO(236, 19, 19, 1)
                                    : Color.fromRGBO(255, 255, 255, 0.3),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Text(
              "Shift",
              style: TextStyle(
                color: const Color.fromRGBO(255, 255, 255, 0.75),
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              width: 250,
              padding: const EdgeInsets.symmetric(vertical: 2),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Color.fromRGBO(255, 255, 255, 0.25),
              ),
              child: StreamBuilder(
                stream: inPremisesStream,
                builder: (context, asyncSnapshot) {
                  final inCollege = asyncSnapshot.data ?? false;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: inCollege
                              ? Color.fromRGBO(99, 255, 156, 1)
                              : const Color.fromARGB(255, 255, 55, 41),

                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 10,
                        width: 10,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        // inCollege
                        inCollege
                            ? "INSIDE CAMPUS ONLY (GEOFENCED)"
                            : "NOT IN COLLEGE PREMISE",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
