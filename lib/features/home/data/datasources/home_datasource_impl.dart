import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/data/models/staff_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';
import 'package:staff_app/features/home/data/models/working_days_model.dart';

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
  Future<StaffHistoryModel> getStaffStatus(DateTime dateTime) async {
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
  Future<void> setStaffStatus(StaffAttendanceEntryModel model) async {
    try {
      await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(model.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<WorkingDaysModel> getWorkingDays(DateTime dateTime) async {
    final workingDaysData = await _firebaseInstance
        .collection("college")
        .doc("working_days")
        .get();

    final data = workingDaysData.data();

    if (data == null || data.isEmpty) {
      return WorkingDaysModel(workingDays: null);
    }

    final Map<String, dynamic>? yearData = data["${dateTime.year}"];

    if (yearData == null || yearData.isEmpty) {
      return WorkingDaysModel(workingDays: null);
    }

    final int? monthData = yearData["${dateTime.month}"];

    if (monthData == null) {
      return WorkingDaysModel(workingDays: null);
    }

    return WorkingDaysModel(workingDays: monthData);
  }

  @override
  Future<WorkingDaysModel> getAttendedDays(DateTime dateTime) async {
    try {
      final attendedDays = await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final result = attendedDays.data();

      if (result == null || result.isEmpty) {
        return WorkingDaysModel(workingDays: null);
      }

      final Map<String, dynamic>? yearResult = result["${dateTime.year}"];

      if (yearResult == null || yearResult.isEmpty) {
        return WorkingDaysModel(workingDays: null);
      }

      final Map<String, dynamic>? monthResult = yearResult["${dateTime.month}"];

      if (monthResult == null || monthResult.isEmpty) {
        return WorkingDaysModel(workingDays: null);
      }

      return WorkingDaysModel(workingDays: monthResult.length);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
