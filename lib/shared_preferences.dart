import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Sharedpreferences extends StatefulWidget {
  @override
  _tanState createState() => _tanState();
}

class _tanState extends State<Sharedpreferences> {
  dynamic name;
  @override
  void initState() {
    super.initState;
    load();
  }

  load() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      name = shared.getString('name') ?? '';
    });
  }

  save(String data) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('name', data);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tan $name')),
      body: Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          child: Text('save'),
          onPressed: () {
            save('tan ax');
          },
        ),
      ),
    );
  }
}
