import 'dart:math';

import 'package:flutter/material.dart';

final Color GRADIENT_TOP = const Color(0xFFF5F5F5);
final Color GRADIENT_BOTTOM = const Color(0xFFE8E8E8);

class EggTimerKnob extends StatefulWidget {
  final rotationPercent;

  EggTimerKnob(this.rotationPercent);
  @override
  _EggTimerKnobState createState() => _EggTimerKnobState();
}

class _EggTimerKnobState extends State<EggTimerKnob> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: ArrowPainter(rotationPercent: widget.rotationPercent),
          ),
        ),
        Container(
            padding: EdgeInsets.all(10),
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
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFDFDFDF), width: 1.5),
              ),
              width: double.infinity,
              child: Center(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationZ(2 * pi * widget.rotationPercent),
                  child: Image.network(
                    'https://www.codemate.com/wp-content/uploads/2017/09/flutter-logo.png',
                    width: 50,
                    height: 50,
                    color: Colors.black,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}

class ArrowPainter extends CustomPainter {
  final Paint dialArrowPaint;
  final double rotationPercent;
  ArrowPainter({this.rotationPercent}) : dialArrowPaint = Paint() {
    dialArrowPaint.color = Colors.black;
    dialArrowPaint.style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    final radius = size.height / 2;

    canvas.translate(radius, radius);
    canvas.rotate(2 * pi * rotationPercent);

    Path path = Path();
    path.moveTo(0, -radius - 10.0);
    path.lineTo(10, -radius + 5);
    path.lineTo(-10, -radius + 5);
    path.close();

    canvas.drawPath(path, dialArrowPaint);
    canvas.drawShadow(path, Colors.black, 3, false);

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
