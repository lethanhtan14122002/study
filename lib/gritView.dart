import 'package:flutter/material.dart';

class GridViewExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // Số cột trong lưới
      children: <Widget>[
        Text('Item 1'),
        Text('Item 2'),
        Text('Item 3'),
        Text('Item 4'),
        Container(
          color: Colors.blue,
          child: Center(child: Text('Item 5')),
        ),
        Container(
          color: Colors.green,
          child: Center(child: Text('Item 6')),
        ),
        SizedBox(width: 20, height: 20),
      ],
    );
  }
}
