import 'package:flutter/material.dart';

class flexble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 2, // Widget này sẽ chiếm 1 phần không gian
          fit: FlexFit.tight, // Chiếm toàn bộ không gian khả dụng
          child: Container(color: Colors.blue, height: 50),
        ),
        Flexible(
          flex: 2, // Widget này sẽ chiếm 2 phần không gian
          fit: FlexFit.loose, // Widget có thể thu nhỏ lại
          child: Container(color: Colors.green, height: 50),
        ),
        Flexible(
          flex: 1, // Widget này sẽ chiếm 1 phần không gian
          fit: FlexFit.tight, // Chiếm toàn bộ không gian khả dụng
          child: Container(color: Colors.red, height: 50),
        ),
      ],
    );
  }
}
