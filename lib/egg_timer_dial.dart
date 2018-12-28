import 'package:flutter/material.dart';
import 'package:timer/egg_timer_knob.dart';
import './radial_drag_gesture.dart';

import 'dart:math';

final Color GRADIENT_TOP = const Color(0xFFF5F5F5);
final Color GRADIENT_BOTTOM = const Color(0xFFE8E8E8);

class EggTimerDial extends StatefulWidget {
  final Duration currentTime;
  final Duration maxTime;
  final int ticksPerSection;
  final Function(Duration) onTimeSelected;

  EggTimerDial({
    this.currentTime = const Duration(minutes: 0),
    this.ticksPerSection = 5,
    this.maxTime = const Duration(minutes: 35),
    this.onTimeSelected,
  });
  @override
  _EggTimerDialState createState() => _EggTimerDialState();
}

class _EggTimerDialState extends State<EggTimerDial> {
  _rotationPercent() {
    return widget.currentTime.inSeconds / widget.maxTime.inSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return DialTurnGestureDetector(
          child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [GRADIENT_TOP, GRADIENT_BOTTOM]),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0.0, 1.0),
                        color: Color(0x44000000),
                        blurRadius: 2,
                        spreadRadius: 1)
                  ],
                ),
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(55),
                      width: double.infinity,
                      height: double.infinity,
                      child: CustomPaint(
                        painter: TickPainter(
                            tickCount: widget.maxTime.inMinutes,
                            ticksPerSection: widget.ticksPerSection),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(65.0),
                      child: EggTimerKnob(_rotationPercent()),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class DialTurnGestureDetector extends StatefulWidget {
  final child;

  DialTurnGestureDetector({this.child});
  @override
  _DialTurnGestureDetectorState createState() => _DialTurnGestureDetectorState();
}

class _DialTurnGestureDetectorState extends State<DialTurnGestureDetector> {

  onDragStart(PolarCoord coord){

  }

  onDragUpdate(PolarCoord coords){

  }

  onDragEnd(){

  }

  @override
  Widget build(BuildContext context) {
    return RadialDragGestureDetector (
      onRadialDragStart: onDragStart ,
      onRadialDragUpdate: onDragUpdate,
      onRadialDragEnd: onDragEnd,
      child: widget.child,
      
    );
  }
}

class TickPainter extends CustomPainter {
  final LONG_TICK = 14.0;
  final SHORT_TICK = 6.0;

  final tickCount;
  final ticksPerSection;
  final tickInset;
  final Paint tickPaint;
  final TextPainter textPainter;
  final textStyle;

  TickPainter({
    this.tickCount = 35,
    this.ticksPerSection = 5,
    this.tickInset = 0.0,
  })  : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
        textStyle = TextStyle(color: Colors.black, fontSize: 20) {
    tickPaint.color = Colors.black;
    tickPaint.strokeWidth = 1.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    canvas.save();

    final radius = size.width / 2;

    for (var i = 0; i < tickCount; ++i) {
      final tickLength = i % ticksPerSection == 0 ? LONG_TICK : SHORT_TICK;
      canvas.drawLine(
          Offset(0.0, -radius), Offset(0.0, -radius - tickLength), tickPaint);

      if (i % ticksPerSection == 0) {
        canvas.save();
        canvas.translate(0.0, -(radius) - 30);
        textPainter.text = TextSpan(text: '$i', style: textStyle);

        textPainter.layout();

        final tickPercent = i / tickCount;
        var quadrant;
        if (tickPercent < .25) {
          quadrant = 1;
        } else if (tickPercent < .5) {
          quadrant = 4;
        } else if (tickPercent < .75) {
          quadrant = 3;
        } else {
          quadrant = 2;
        }

        switch (quadrant) {
          case 4:
            canvas.rotate(-pi / 2);
            break;

          case 2:

          case 3:
            canvas.rotate(pi / 2);
            break;
        }

        textPainter.paint(
            canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));

        canvas.restore();
      }
      canvas.rotate(2 * pi / tickCount);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
