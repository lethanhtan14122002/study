import 'package:flutter/material.dart';
import 'cuonngang.dart';
import 'main.dart';

class NutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Nút Button bằng InkWell ',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50, left: 100),
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),

          width: 100,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.withOpacity(0.7),
                Colors.blue.withOpacity(0.6),
                Colors.green.withOpacity(0.6),
                Colors.purple.withOpacity(0.7),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => singlechildscrollview(),
                ),
              );
            },
            child: Center(
              child: Text(
                'Nút Bấm',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
