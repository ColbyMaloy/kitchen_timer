import 'package:flutter/material.dart';

class EggTimerDisplay extends StatefulWidget {
  @override
  _EggTimerDisplayState createState() => _EggTimerDisplayState();
}

class _EggTimerDisplayState extends State<EggTimerDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Text(
        "4:32",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 100),
      ),
    );
  }
}
