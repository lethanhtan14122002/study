import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
import 'ontap.dart';
import 'api.dart';
import 'hieuung.dart';
import 'api_no_key.dart';
import 'ontapapi.dart';
import 'firebase.dart';
import 'listfirebase.dart';
import 'addlistbase.dart';
import 'add_update_clrea.dart';
import 'table.dart';
import 'random.dart';
import 'canvar.dart';
import 'animation_canvar.dart';
import 'ontap2.dart';
import 'ontap_api_table_firebase.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings = Settings(
  //   persistenceEnabled: true,
  // ); //bật chế độ lưu cục bộ khi không có wifi .
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      debugShowCheckedModeBanner: false,
      initialRoute: 'ontap3',
      routes: {
        'ontap3': (context) => ontap3(),
        'ontap2': (context) => ontap2(),
        'animation_canvar': (context) => RotatingCircle(),
        'canvar': (context) => canvar(),
        'random': (context) => Randomwidget(),
        'them': (context) => them(),
        'themxoasua': (context) => themxoasua(),
        'addlist': (context) => addlist(),
        'ontapapi': (context) => Ontapapi(),
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
        'acontroller': (context) => AnimatedController(),
        'hieuung': (context) => hieuung(),
        'ontap': (context) => ontap(),
        'api': (context) => WeatherScreen(),
        'apino': (context) => TarotCardScreen(),
        'firebase': (context) => FirebasePage(),
        'listbase': (context) => listfirebase(),
      },
    );
  }
}
