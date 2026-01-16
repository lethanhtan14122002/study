import 'package:flutter/material.dart';

class hieuung extends StatefulWidget {
  @override
  hieuungState createState() => hieuungState();
}

class hieuungState extends State<hieuung> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animated;
  late Animation<double> size;
  late Animation<Color?> color;

  @override
  void initState() {
    super.initState();
    load();
  }

  void dispose() {
    super.dispose();
  }

  void load() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: false);
    animated = Tween<double>(
      begin: 0,
      end: 220,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    size = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    color = ColorTween(
      begin: Colors.green.withOpacity(0.5),
      end: Colors.purple.withOpacity(1),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: 200,
        height: 100,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          children: [
            Positioned(
              left: animated.value, // Di chuyển theo giá trị của animation
              child: Container(
                child: ElevatedButton(
                  onPressed: () {},
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return Container(
                        width: size.value,
                        height: size.value,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.value?.withOpacity(0.5) ??
                                  Colors.blue.withOpacity(0.8),
                              color.value?.withOpacity(0.5) ??
                                  Colors.blue.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
