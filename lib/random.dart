import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Randomwidget extends StatefulWidget {
  @override
  random1State createState() => random1State();
}

class random1State extends State<Randomwidget> {
  Random _random = Random();
  dynamic i;
  dynamic name;
  final String _letters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

  void random5(int length) {
    setState(() {
      name = List.generate(length, (index) {
        int iny = _random.nextInt(_letters.length);
        return _letters[iny];
      }).join();
    });
  }

  Future<void> random2() async {
    try {
      i = _random.nextInt(100);
      setState(() {
        i;
      });
    } catch (e) {
      print('loi $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('random')),
      body: Center(
        child: Container(
          width: double.infinity,
          height: 200,
          child: Column(
            children: [
              Center(child: Text('$i')),
              Center(child: Text('$name')),

              ElevatedButton(
                onPressed: () => random2(),
                child: Center(child: Text('random')),
              ),
              ElevatedButton(
                onPressed: () => random5(10),
                child: Center(child: Text('random')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
