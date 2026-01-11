import 'package:flutter/material.dart';

class singlechildscrollview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tanax')),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(width: 200, height: 200, color: Colors.red),
            Container(width: 200, height: 200, color: Colors.blue),
            Container(width: 200, height: 200, color: Colors.green),
            Container(width: 200, height: 200, color: Colors.purple),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.withOpacity(0.7),
                    Colors.pink.withOpacity(0.6),
                    Colors.cyan.withOpacity(0.6),
                    Colors.lime.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Colors.purple.withOpacity(1),
                highlightColor: const Color.fromARGB(
                  255,
                  182,
                  210,
                  38,
                ).withOpacity(1),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text(
                    'Quay Lại',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
