import 'package:flutter/material.dart';

// CustomPainter để vẽ trên Canvas
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Tạo một đối tượng Paint để xác định màu sắc, độ dày của đường viền
    Paint paint = Paint()
      ..color = Colors
          .blue // Màu sắc của hình tròn
      ..style =
          PaintingStyle.fill; // Vẽ hình tròn đầy (chứ không phải chỉ viền)

    // Vẽ hình tròn tại vị trí (150, 150) với bán kính 100
    canvas.drawCircle(Offset(130, 100), 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // Không cần vẽ lại nếu không có thay đổi
    return false;
  }
}

class canvar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Canvas Example')),
        body: CustomPaint(
          size: Size(double.infinity, double.infinity), // Kích thước của Canvas
          painter: CirclePainter(), // Sử dụng CustomPainter để vẽ
        ),
      ),
    );
  }
}
