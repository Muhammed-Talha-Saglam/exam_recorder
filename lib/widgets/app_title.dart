import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Shimmer give a shining effect to its child widget
    return Shimmer.fromColors(
        baseColor: Colors.black,
        highlightColor: Colors.white,
        child: Text("Exams Recorder"));
  }
}
