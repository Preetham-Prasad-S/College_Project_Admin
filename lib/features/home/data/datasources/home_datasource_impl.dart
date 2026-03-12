import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
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

      final result = staffHistory.data();

      if (result == null || result.isEmpty) {
        return StaffHistoryModel(clockIn: null, clockOut: null);
      }

      final Map<String, dynamic>? yearResult = result["${dateTime.year}"];

      if (yearResult == null || yearResult.isEmpty) {
        return StaffHistoryModel(clockIn: null, clockOut: null);
      }

      final Map<String, dynamic>? monthResult = yearResult["${dateTime.month}"];

      print(monthResult);

      if (monthResult == null || monthResult.isEmpty) {
        return StaffHistoryModel(clockIn: null, clockOut: null);
      }

      final Map<String, dynamic>? dateResult = monthResult["${dateTime.day}"];

      if (dateResult == null || dateResult.isEmpty) {
        return StaffHistoryModel(clockIn: null, clockOut: null);
      }
      return StaffHistoryModel.fromJson(dateResult);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> setStaffHistory(StaffAttendanceEntryModel model) async {
    try {
      await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(model.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
