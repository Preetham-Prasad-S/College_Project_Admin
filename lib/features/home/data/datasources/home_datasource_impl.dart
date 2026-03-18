import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_app/core/exceptions.dart';
import 'package:staff_app/features/home/data/datasources/home_datasource.dart';
import 'package:staff_app/features/home/data/models/college_location_model.dart';
import 'package:staff_app/features/home/data/models/college_holidays_model.dart';
import 'package:staff_app/features/home/data/models/staff_monthly_history_model.dart';
import 'package:staff_app/features/home/data/models/staff_shift_model.dart';

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
  Future<void> setCurrentMonthHistory({
    required int year,
    required int month,
    required StaffMonthlyHistoryModel model,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final docRef = _firebaseInstance.collection("history").doc(userId);

      await docRef.set({
        "$year": {"$month": model.toJson()},
      }, SetOptions(merge: true));
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
        throw ServerException(
          message: "No Holiday Data Found : HomeDatasource.getHolidayDays",
        );
      }

      final Map<String, dynamic>? yearData = holiday["${dateTime.year}"];

      if (yearData == null || yearData.isEmpty) {
        throw ServerException(
          message:
              "No Holiday Data Found For The Year ${dateTime.year} : HomeDatasource.getHolidayDays",
        );
      }

      final List<dynamic>? monthData = yearData["${dateTime.month}"];

      if (monthData == null || monthData.isEmpty) {
        throw ServerException(
          message:
              "No Holiday Data Found For The Month ${dateTime.month} : HomeDatasource.getHolidayDays",
        );
      }

      return CollegeHolidaysModel.fromJson(monthData);
    } catch (e) {
      throw ServerException(message: "$e -> HomeDatasource.getHolidayDays");
    }
  }

  @override
  Future<StaffMonthlyHistoryModel> getCurrentMonthHistory(
    DateTime currentDateTime,
  ) async {
    try {
      final attendedDays = await _firebaseInstance
          .collection("history")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      final result = attendedDays.data();

      if (result == null || result.isEmpty) {
        throw DataException(
          message: "No History Found : HomeDatasource.getCurrentMonthHistory()",
        );
      }

      final Map<String, dynamic>? yearResult =
          result["${currentDateTime.year}"];

      if (yearResult == null || yearResult.isEmpty) {
        throw DataException(
          message:
              "No History Found  For Year ${currentDateTime.year} : HomeDatasource.getCurrentMonthHistory()",
        );
      }

      final Map<String, dynamic>? rawMonth =
          yearResult["${currentDateTime.month}"];

      if (rawMonth == null || rawMonth.isEmpty) {
        throw DataException(
          message:
              "No History Found For month ${currentDateTime.year} : HomeDatasource.getCurrentMonthHistory()",
        );
      }

      return StaffMonthlyHistoryModel.fromJson(rawMonth);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
