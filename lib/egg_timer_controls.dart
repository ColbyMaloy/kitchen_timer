import 'package:flutter/material.dart';
import 'package:timer/egg_timer_button.dart';

class EggTimerControls extends StatefulWidget {
  @override
  _EggTimerControlsState createState() => _EggTimerControlsState();
}

class _EggTimerControlsState extends State<EggTimerControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            EggTimerButton(
              icon: Icons.refresh,
              text: "RESTART",
            ),
            EggTimerButton(
              icon: Icons.arrow_back,
              text: "RESET",
            )
          ],
        ),
        EggTimerButton(
          icon: Icons.pause,
          text: "PAUSE",
        )
      ],
    );
  }
}
