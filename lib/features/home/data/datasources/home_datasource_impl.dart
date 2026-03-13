import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/college_holidays_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_entry_model.dart';
import 'package:staff_app/features/home/data/models/staff_attendance_status_model.dart';
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
  Future<CollegeHolidaysModel> getHolidayDays(DateTime dateTime) async {
    try {
      final holidayData = await _firebaseInstance
          .collection("college")
          .doc("holidays")
          .get();

      final holiday = holidayData.data();

      if (holiday == null || holiday.isEmpty) {
        return CollegeHolidaysModel(holidayDates: null);
      }

      final Map<String, dynamic>? yearData = holiday["${dateTime.year}"];

      if (yearData == null || yearData.isEmpty) {
        return CollegeHolidaysModel(holidayDates: null);
      }

      final List<Map<String, dynamic>>? monthData =
          (yearData["${dateTime.month}"] as List<dynamic>?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList();

      if (monthData == null || monthData.isEmpty) {
        return CollegeHolidaysModel(holidayDates: null);
      }

      return CollegeHolidaysModel(holidayDates: monthData);
    } catch (e) {
      throw ServerException(message: "$e -> DataSource");
    }
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

  @override
  Future<StaffAttendanceStatusModel> getStaffAttendanceHistory() async {
    try {
      final staffAttendanceHistoryData = await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final staffAttendanceHistory = staffAttendanceHistoryData.data();

      if (staffAttendanceHistory == null || staffAttendanceHistory.isEmpty) {
        return StaffAttendanceStatusModel(present: false);
      }

      final Map<String, dynamic>? yearResult = result["${dateTime.year}"];

      if (yearResult == null || yearResult.isEmpty) {
        return StaffAttendanceStatusModel(present: false);
      }

      final Map<String, dynamic>? monthResult = yearResult["${dateTime.month}"];

      if (monthResult == null || monthResult.isEmpty) {
        return StaffAttendanceStatusModel(present: false);
      }

      return StaffAttendanceStatusModel(present: true);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
