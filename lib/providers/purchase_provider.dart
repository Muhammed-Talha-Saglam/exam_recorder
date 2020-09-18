import 'package:budget_planner/models/exam.dart';
import 'package:budget_planner/services/db_helper.dart';
import 'package:flutter/material.dart';

class PurchaseProvider with ChangeNotifier {
  List<Exam> _exams = [];

  List<Exam> get exams {
    return _exams;
  }

  Future<void> fetchFromDb() async {
    final dataList = await DBHelper.getData("exams");
    _exams = dataList.map((item) => Exam.fromMap(item)).toList();
    notifyListeners();
  }

  Future<void> addToDb(Map<String, dynamic> data) async {
    await DBHelper.insert("exams", data);
    // We call this function to refresh the data on the screen
    await fetchFromDb();
  }

  Future<void> deleteFromDb(String id) async {
    await DBHelper.delete("exams", id);
    // We call this function to refresh the data on the screen
    await fetchFromDb();
  }
}
