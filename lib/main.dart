import 'package:flutter/material.dart';
import 'package:timer/egg_timer.dart';
import 'package:timer/egg_timer_button.dart';
import 'package:timer/egg_timer_controls.dart';
import 'package:timer/egg_timer_dial.dart';
import 'package:timer/egg_timer_interface.dart';

final Color GRADIENT_TOP = const Color(0xFFF5F5F5);
final Color GRADIENT_BOTTOM = const Color(0xFFE8E8E8);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  EggTimer eggTimer;

  _MyHomePageState() {
    eggTimer = new EggTimer(
        maxTime: const Duration(minutes: 35), onTimerUpdate: onTimerUpdate);
  }

  onDialStopTurning(Duration newTime) {
    setState(() {
      eggTimer.currentTime = newTime;
      eggTimer.resume();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
        duration: Duration(milliseconds: 5000), vsync: this);
    _animation = Tween(begin: 200.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  onTimerUpdate() {
    setState(() {});
  }

  onTimeSelected(Duration newTime) {
    setState(() {
      eggTimer.currentTime = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [GRADIENT_TOP, GRADIENT_BOTTOM])),
        child: Center(
          child: Column(
            children: <Widget>[
              EggTimerDisplay(
                eggTimerState: eggTimer.state,
                selectionTime: eggTimer.lastStartTime,
                countdownTime: eggTimer.currentTime,
              ),
              EggTimerDial(
                currentTime: eggTimer.currentTime,
                maxTime: eggTimer.maxTime,
                onTimeSelected: onTimeSelected,
                onDialStopTurning: onDialStopTurning,
              ),
              Expanded(
                child: Container(),
              ),
              EggTimerControls(
                eggTimerState: eggTimer.state,
                onPause: () {
                  setState(() {
                    eggTimer.pause();
                  });
                },
                onResume: () {
                  setState(() {
                    eggTimer.resume();
                  });
                },
                onRestart: () {
                  setState(() {
                    eggTimer.restart();
                  });
                },
                onReset: () {
                  setState(() {
                    eggTimer.reset();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
