import 'package:flutter/material.dart';
import 'dart:async';

class animatedcontroller extends StatefulWidget {
  @override
  animateState createState() => animateState();
}

class animateState extends State<animatedcontroller>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  bool isbig = false;
  Timer? time;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: false);

    animation = Tween<double>(
      begin: 5,
      end: 250,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  void load() {
    time = Timer.periodic(const Duration(seconds: 1), (time) {
      if (mounted) {
        setState(() {
          isbig = !isbig;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                left: animation.value,
                top: 50,
                child: Container(
                  width: isbig ? 200 : 100,
                  height: isbig ? 200 : 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.withOpacity(0.5),
                        Colors.yellow.withOpacity(0.5),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
