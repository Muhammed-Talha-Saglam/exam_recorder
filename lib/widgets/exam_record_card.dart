import 'package:budget_planner/models/exam.dart';
import 'package:budget_planner/providers/purchase_provider.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class ExamRecordCard extends StatelessWidget {
  const ExamRecordCard({
    Key key,
    @required this.item,
    @required this.provider,
  }) : super(key: key);

  final Exam item;
  final PurchaseProvider provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.deepPurple,
              Colors.indigoAccent.withOpacity(0.3),
            ],
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Course : ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Correct : ",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Wrong  : ",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    item.correct.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    item.wrong.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    formatDate(
                        DateTime.parse(item.date), [yyyy, '-', mm, '-', dd]),
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        provider.deleteFromDb(item.id);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
