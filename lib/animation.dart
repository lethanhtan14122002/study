import 'dart:async';

import 'package:flutter/material.dart';

class animated extends StatefulWidget {
  @override
  _animatedState createState() => _animatedState();
}

class _animatedState extends State<animated> {
  bool isbig = false;
  Timer? time;
  // double _size = 100;
  // Color _color = Colors.red;

  @override
  void initState() {
    super.initState();
    animate();
  }

  void animate() {
    time = Timer.periodic(const Duration(seconds: 6), (time) {
      if (mounted) {
        setState(() {
          isbig = !isbig;
          // _size = _size == 100 ? 200 : 100;
          // _color = _color == Colors.red ? Colors.blue : Colors.red;
        });
      }
    });
  }

  void dispose() {
    time?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('animated example')),
      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,

        child: AnimatedContainer(
          alignment: isbig ? Alignment.centerLeft : Alignment.bottomCenter,
          duration: const Duration(seconds: 4),
          curve: Curves.easeInOut,
          color: Colors.red.withOpacity(0.4),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: isbig ? Colors.red : Colors.blue,
            ),
            width: isbig ? 200 : 100,
            height: isbig ? 200 : 100,
          ),
        ),
      ),
    );
  }
}
