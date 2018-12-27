import 'package:flutter/material.dart';
import 'package:timer/egg_timer_button.dart';
import 'package:timer/egg_timer_controls.dart';
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
              EggTimerDisplay(),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0.0, 1.0),
                                  color: Color(0x44000000),
                                  blurRadius: 2,
                                  spreadRadius: 1)
                            ],
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [GRADIENT_TOP, GRADIENT_BOTTOM])),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(65.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0.0, 1.0),
                                      color: Color(0x44000000),
                                      blurRadius: 2,
                                      spreadRadius: 1)
                                ],
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [GRADIENT_TOP, GRADIENT_BOTTOM])),
                            width: double.infinity,
                            child: Container(),
                          ),
                        ),
                      )),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              EggTimerControls()
            ],
          ),
        ),
      ),
    );
  }
}
