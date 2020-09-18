import 'package:budget_planner/providers/purchase_provider.dart';
import 'package:budget_planner/screens/main_screen.dart';
import 'package:budget_planner/styles/app_Colors.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uuid/uuid.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  int correct = 0;
  int wrong = 0;
  String date = "";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PurchaseProvider>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Center(
              child: Shimmer.fromColors(
                direction: ShimmerDirection.rtl,
                baseColor: Colors.red,
                highlightColor: Colors.white,
                child: Text(
                  "Add A New Exam",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: TextFormField(
                        validator: (value) {
                          // If the form field is empty, show error
                          if (value.isEmpty) {
                            return "Please, enter the course";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Course",
                          hintText: "Course",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid),
                          ),
                        ),
                        onChanged: (value) {
                          name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: TextFormField(
                        validator: (value) {
                          // If the form field is empty, show error
                          if (value.isEmpty) {
                            return "Please, enter the number of correct answers";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Correct answers",
                          hintText: "Correct answers",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          correct = double.parse(value).round();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
                      child: TextFormField(
                        // If the form field is empty, show error
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please, enter the number of wrong answers";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          labelText: "Wrong answers",
                          hintText: "Wrong answers",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          wrong = double.parse(value).round();
                        },
                      ),
                    ),
                    date != ""
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Row(
                              children: [
                                Icon(
                                  LineAwesomeIcons.calendar,
                                ),
                                SizedBox(width: 25),
                                Text(
                                  formatDate(DateTime.parse(date),
                                      [yyyy, '-', mm, '-', dd]),
                                  style: TextStyle(fontSize: 25),
                                ),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: Row(children: [
                              const Icon(
                                LineAwesomeIcons.calendar,
                                color: Colors.black,
                                size: 30,
                              ),
                              const SizedBox(width: 25),
                              InkWell(
                                  child: Text(
                                    "Choose the date",
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      decoration: TextDecoration.underline,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2001),
                                      lastDate: DateTime(2050),
                                    ).then((time) {
                                      var dt = time.toIso8601String();
                                      setState(() {
                                        date = dt;
                                      });
                                    });
                                  }),
                            ]),
                          ),
                    const SizedBox(height: 25),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed: () async {
                        // If the form field values input by the user are true, add to the database
                        if (_formKey.currentState.validate() &&
                            date.isNotEmpty) {
                          provider.addToDb({
                            // Uuid class generates a random unique id
                            "id": Uuid().v1(),
                            "name": name,
                            "correct": correct,
                            "wrong": wrong,
                            "date": date
                          }).then((value) => Navigator.of(context).push(
                              // After adding the data to the database, return to the main page
                              MaterialPageRoute(
                                  builder: (context) => MainPage())));
                        }
                      },
                      child: const Text("Add"),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
