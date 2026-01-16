import 'package:flutter/material.dart';
import 'dart:async';

class AnimatedController extends StatefulWidget {
  @override
  animatedState createState() => animatedState();
}

class animatedState extends State<AnimatedController>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animated;
  late Animation<double> sizeAnimation;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat(reverse: false);
    animated = Tween<double>(
      begin: 0,
      end: 220,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    sizeAnimation = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    colorAnimation = ColorTween(
      begin: Colors.green.withOpacity(0.3),
      end: Colors.purple.withOpacity(0.7),
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned(
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Positioned(
                  left: animated
                      .value, // Điều chỉnh để di chuyển từ trái sang phải
                  top: 200,

                  child: Container(
                    width: sizeAnimation
                        .value, // Thay đổi kích thước theo animation
                    height: sizeAnimation.value,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          colorAnimation.value ??
                              const Color.fromARGB(
                                255,
                                216,
                                246,
                                224,
                              ).withOpacity(0.3),
                          Colors.green.withOpacity(0.3), // Màu thứ 2
                          const Color.fromARGB(
                            255,
                            86,
                            10,
                            186,
                          ).withOpacity(0.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(50), // Giữ hình tròn
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
