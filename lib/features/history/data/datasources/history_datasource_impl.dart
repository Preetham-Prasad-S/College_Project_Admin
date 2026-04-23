import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:staff_app/features/history/data/datasources/history_datasource.dart';
import 'package:staff_app/features/history/data/models/month_history_model.dart';

class HistoryDatasourceImpl implements HistoryDatasource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  HistoryDatasourceImpl({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore;

  @override
  Future<MonthHistoryModel?> getMonthHistory(DateTime selectedTime) async {
    final result = await _firebaseFirestore
        .collection("history")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    final data = result.data();

    if (data == null || data.isEmpty) {
      return null;
    }

    final yearData = data[selectedTime.year.toString()];

    if (yearData == null || yearData.isEmpty) {
      return null;
    }

    final monthData = yearData[selectedTime.month.toString()];

    if (monthData == null || monthData.isEmpty) {
      return null;
    }

    return MonthHistoryModel.fromJson(monthData);
  }
}
