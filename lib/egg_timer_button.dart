import 'package:flutter/material.dart';

class EggTimerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onPressed;

  EggTimerButton({this.icon, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.brown,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Icon(
                icon,
                color: Colors.black,
              ),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }
}
