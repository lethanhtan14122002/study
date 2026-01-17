import 'package:flutter/material.dart';

class hieuung extends StatefulWidget {
  @override
  hieuungState createState() => hieuungState();
}

class hieuungState extends State<hieuung> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animated;

  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: false);
    animated = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50),
              alignment: Alignment.center,
              width: 300,
              height: 300,
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(controller.value * 200, 0),
                    child: child,
                  );
                },
                child: Image.asset('assets/love.jpg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
