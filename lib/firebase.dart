import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class FirebasePage extends StatefulWidget {
  @override
  _FirebasePageState createState() => _FirebasePageState();
}

class _FirebasePageState extends State<FirebasePage> {
  // Firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Future để lấy dữ liệu từ Firestore
  Future<DocumentSnapshot> getData() async {
    return await firestore.collection('tan').doc('viptan').get();
  }

  // Firebase initialization

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Firestore Example')),
      body: FutureBuilder(
        future: getData(), // Chờ Firebase khởi tạo
        builder: (context, snapshot) {
          // Nếu Firebase chưa khởi tạo
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // Nếu có lỗi khi khởi tạo Firebase
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('no fire'));
          }
          var vip = snapshot.data!.data() as Map<String, dynamic>;
          dynamic t = vip['vui'];
          return Center(child: Text(t));
        },
      ),
    );
  }
}
