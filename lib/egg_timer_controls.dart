import 'package:flutter/material.dart';
import 'package:timer/egg_timer.dart';
import 'package:timer/egg_timer_button.dart';

class EggTimerControls extends StatefulWidget {
  final eggTimerState;
  final Function() onPause;
  final Function() onResume;
  final Function() onRestart;
  final Function() onReset;

  EggTimerControls(
      {this.eggTimerState,
      this.onPause,
      this.onResume,
      this.onRestart,
      this.onReset});
  @override
  _EggTimerControlsState createState() => _EggTimerControlsState();
}

class _EggTimerControlsState extends State<EggTimerControls> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Opacity(
          opacity: 1.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              EggTimerButton(
                icon: Icons.refresh,
                text: "RESTART",
                onPressed: widget.onRestart,
              ),
              EggTimerButton(
                icon: Icons.arrow_back,
                text: "RESET",
                onPressed: widget.onReset,
              )
            ],
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(0, 0, 0),
          child: EggTimerButton(
              icon: widget.eggTimerState == EggTimerState.running
                  ? Icons.pause
                  : Icons.play_arrow,
              text: widget.eggTimerState == EggTimerState.running
                  ? "PAUSE"
                  : "RESUME",
              onPressed: widget.eggTimerState == EggTimerState.running
                  ? widget.onPause
                  : widget.onResume),
        )
      ],
    );
  }
}
