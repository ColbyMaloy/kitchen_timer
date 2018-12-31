import 'package:flutter/material.dart';
import 'package:timer/egg_timer.dart';


class EggTimerDisplay extends StatefulWidget {
  final eggTimerState;
  final countdownTime;
  final selectionTime;

  EggTimerDisplay(
      {this.eggTimerState,
      this.countdownTime = const Duration(seconds: 0),
      this.selectionTime = const Duration(seconds: 0)});
  @override
  _EggTimerDisplayState createState() => _EggTimerDisplayState();
}

class _EggTimerDisplayState extends State<EggTimerDisplay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0,
                widget.eggTimerState == EggTimerState.ready ? 0.0 : -200 - 50.0,
                0.0),
            child: Text(
              "${widget.selectionTime.inMinutes}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 100),
            ),
          ),
          Opacity(
            opacity: widget.eggTimerState != EggTimerState.ready ? 1.0 : 0.0,
            child: Text(
              "${widget.countdownTime.inSeconds}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 100),
            ),
          ),
        ],
      ),
    );
  }
}
