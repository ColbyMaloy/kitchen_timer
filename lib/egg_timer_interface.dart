import 'package:flutter/material.dart';
import 'package:timer/egg_timer.dart';
import 'package:intl/intl.dart';

class EggTimerDisplay extends StatefulWidget {
  final eggTimerState;
  final countdownTime;
  final selectionTime;

  EggTimerDisplay({
    this.eggTimerState,
    this.countdownTime = const Duration(seconds: 0),
    this.selectionTime = const Duration(seconds: 0),
  });
  @override
  _EggTimerDisplayState createState() => _EggTimerDisplayState();
}

class _EggTimerDisplayState extends State<EggTimerDisplay>
    with TickerProviderStateMixin {
  final DateFormat selectionTimeFormat = DateFormat('mm');
  final DateFormat countdownTimeFormat = DateFormat('mm:ss');

  AnimationController selectionSlideController;
  AnimationController coundownFadeController;

  @override
  void initState() {
    super.initState();
    selectionSlideController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });
    coundownFadeController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600))
      ..addListener(() {
        setState(() {});
      });
      coundownFadeController.value = 1.0;
  }

  @override
  void dispose() {
    selectionSlideController.dispose();
    coundownFadeController.dispose();

    super.dispose();
  }

  get _formatSelection {
    DateTime dateTime = DateTime(
        DateTime.now().year, 0, 0, 0, 0, widget.selectionTime.inSeconds);
    return selectionTimeFormat.format(dateTime);
  }

  get _formatCountdown {
    DateTime dateTime = DateTime(
        DateTime.now().year, 0, 0, 0, 0, widget.countdownTime.inSeconds);
    return countdownTimeFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.eggTimerState == EggTimerState.ready) {
      selectionSlideController.reverse();
      coundownFadeController.forward();
    } else {
      selectionSlideController.forward();
      coundownFadeController.reverse();
    }
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, -200 * selectionSlideController.value, 0.0),
            child: Text(
              _formatSelection,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 100),
            ),
          ),
          Opacity(
            opacity: 1 - coundownFadeController.value,
            child: Text(
              _formatCountdown,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 100),
            ),
          ),
        ],
      ),
    );
  }
}
