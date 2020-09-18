import 'package:budget_planner/providers/purchase_provider.dart';
import 'package:budget_planner/screens/add_screen.dart';
import 'package:budget_planner/styles/app_Colors.dart';
import 'package:budget_planner/widgets/app_title.dart';
import 'package:budget_planner/widgets/exam_record_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 0 is the main page, 1 is the add item page
  var _pageIndex = 0;

  // This changes the page based on the index of the icon pressed in the bottom navigation bar.
  void changePage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // With provider we can reach the database and listen to the changes
    var provider = Provider.of<PurchaseProvider>(context);

    // We get the latest data from the database
    provider.fetchFromDb();

    // With provider, we can manages the data from a single source of truth
    // So, data is stored at the device database and separated from the UI logic.
    var items = provider.exams;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kAppBarColor,
        // Making a widget const prevent them from being redrawn and this increases performance
        // if the state of a widget will not change during the life cycle of the app, make them const
        title: const AppTitle(),
      ),
      bottomNavigationBar: buildCurvedNavigationBar(),

      // Body changes based on the value of the _pageIndex variable.
      // The value of the _pageIndex is determined by the bottom navigation bar.
      body: _pageIndex == 1

          // Show add item page .
          ? AddItem()
          : items.length < 1

              // If there is no saved record, show "No item to show" text.
              ? Center(
                  child: const Text(
                    "No item to show",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )

              // If there is any item, make a list of them.
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    // Create a custom card for each exam record
                    return ExamRecordCard(
                        item: items[index], provider: provider);
                  }),
    );
  }

  // This function returns a navigation bar using an external library;
  CurvedNavigationBar buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      items: [
        Icon(
          LineAwesomeIcons.list,
          color: Colors.white,
        ),
        Icon(
          LineAwesomeIcons.plus,
          color: Colors.white,
        ),
      ],
      onTap: (index) => changePage(index),
      height: 60,
      animationDuration: Duration(milliseconds: 150),
      backgroundColor: kBackgroundColor,
      color: kNavBarColor,
      buttonBackgroundColor: kNavBarBackgroundColor,
      animationCurve: Curves.easeIn,
    );
  }
}
