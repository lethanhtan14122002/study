import 'package:flutter/material.dart';

class expanded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(color: Colors.yellow, width: 50, height: 100),
        Expanded(flex: 4, child: Container(color: Colors.red, height: 100)),
        Expanded(flex: 1, child: Container(color: Colors.blue, height: 100)),
        Expanded(flex: 1, child: Container(color: Colors.green, height: 100)),
      ],
    );
  }
}
