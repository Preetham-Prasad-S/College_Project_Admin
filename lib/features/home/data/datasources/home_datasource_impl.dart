import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/staff_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_status_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';
import 'package:staff_app/features/home/dependency.dart';

class HomeDatasourceImpl implements HomeDatasource {
  final FirebaseFirestore _firebaseInstance;

  HomeDatasourceImpl({required FirebaseFirestore firebaseInstance})
    : _firebaseInstance = firebaseInstance;

  @override
  Future<CollegeLocationModel> getCollegeLocation() async {
    try {
      final collegeLocation = await _firebaseInstance
          .collection("college")
          .doc("location_details")
          .get();

      return CollegeLocationModel.fromJson(collegeLocation["location"]);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<StaffShiftModel> getStaffShift() async {
    try {
      final staffShift = await _firebaseInstance
          .collection("college")
          .doc("shift_details")
          .get();
      return StaffShiftModel.fromJson(staffShift["normal_shift"]);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<StaffStatusModel> getStaffStatus() async {
    try {
      final staffStatus = await _firebaseInstance
          .collection("staff_status")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      return StaffStatusModel.fromJson(staffStatus["status"]);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<StaffHistoryModel> getStaffHistory(DateTime dateTime) async {
    try {
      final staffHistory = await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final Map<String, dynamic>? data =
          staffHistory["staff_history"]["${dateTime.year}"]["${dateTime.month}"]["${dateTime.day}"];

      if (data == null) {
        throw ServerException(message: "Error in getting staff history");
      }

      return StaffHistoryModel.fromJson(data);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> setStaffHistory(StaffHistoryModel model) async {
    try {
      final data = await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final result = data.data();

      print(result);

      // if (result == null) {
      //   throw ServerException(message: "No Correct key found in DB");
      // }

      // result["staff_history"][model.clockIn.year][model.clockIn.month][model
      //         .clockIn
      //         .day]["clock_in"] =
      //     model.clockIn.millisecondsSinceEpoch;

      // result["staff_history"][model.clockOut.year][model.clockOut.month][model
      //         .clockOut
      //         .day]["clock_out"] =
      //     model.clockIn.millisecondsSinceEpoch;
      // await _firebaseInstance
      //     .collection("history")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .set(result);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
