import 'package:flutter/material.dart';
import 'nutbutton.dart';
import 'gritView.dart';
import 'cuonngang.dart';
import 'expanded.dart';
import 'flexble.dart';
import 'shared_preferences.dart';
import 'share_textfile.dart';
import 'takeimage.dart';
import 'image.dart';
import 'animation.dart';
import 'animated_controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      initialRoute: 'acontroller',
      routes: {
        'nutbutton': (context) => NutButton(),
        'gridview': (context) => GridViewExample(),
        'cuonngang': (context) => singlechildscrollview(),
        'expanded': (context) => expanded(),
        'flexble': (context) => flexble(),
        'shared': (context) => Sharedpreferences(),
        'sharetext': (context) => ShareTextFile(),
        'image': (context) => ImagePickerPage(),
        'vip': (context) => anh(),
        'animation': (context) => animeted(),
        'acontroller': (context) => animatedcontroller(),
      },
    );
  }
}
