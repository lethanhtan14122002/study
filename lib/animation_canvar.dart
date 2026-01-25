import 'dart:math';

import 'package:flutter/material.dart';

class RotatingCircle extends StatefulWidget {
  @override
  _RotatingCircleState createState() => _RotatingCircleState();
}

class _RotatingCircleState extends State<RotatingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Tạo một AnimationController với thời gian vòng quay 5 giây
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: false);

    // Tạo một animation quay từ 0 đến 2*pi (360 độ)
    _animation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Bắt đầu animation
    // Lặp lại animation vô hạn
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: CirclePainter(animation: _animation),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Animation<double> animation;

  CirclePainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // Lấy trung tâm của canvas
    Offset center = Offset(size.width / 2, size.height / 2);
    // Tính toán vị trí của hình tròn theo góc quay
    double radius = 100; // Bán kính của vòng quay
    double x = center.dx + radius * cos(animation.value);
    double y = center.dy + radius * sin(animation.value);

    // Vẽ hình tròn tại vị trí mới
    canvas.drawCircle(Offset(x, y), 20, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true; // Cần vẽ lại khi animation thay đổi
  }
}
