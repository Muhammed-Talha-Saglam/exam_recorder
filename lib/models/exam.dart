import 'package:flutter/material.dart';

class Exam {
  final String id;
  final String name;
  final int correct;
  final int wrong;
  final String date;

  Exam(
      {this.id,
      @required this.name,
      @required this.correct,
      @required this.wrong,
      @required this.date});

  factory Exam.fromMap(Map<String, dynamic> data) {
    return Exam(
      id: data["id"],
      name: data["name"],
      correct: data["correct"],
      wrong: data["wrong"],
      date: data["date"],
    );
  }
}
