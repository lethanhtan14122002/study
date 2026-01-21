import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebasePage extends StatefulWidget {
  @override
  firebaseState createState() => firebaseState();
}

class firebaseState extends State<FirebasePage> {
  final FirebaseFirestore fire = FirebaseFirestore.instance;

  dynamic show;
  dynamic show1;

  Future<DocumentSnapshot> getdata() async {
    dynamic tan = await fire.collection('tan').doc('viptan').get();

    return tan;
  }

  Future<void> add() async {
    try {
      await fire.collection('tan').doc('viptan').set({
        'id': 'tan 0',
        'vui': 'tan vui thoi',
        'time': FieldValue.serverTimestamp(),
      });
      var t = await fire.collection('tan').doc('viptan').get();
      setState(() {
        show = t['vui'];
        show1 = t['id'];
      });
    } catch (e) {
      print(' $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tan ax')),
      body: Column(
        children: <Widget>[
          FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Center(child: Text('loi: ${snapshot.hasError}'));
              }
              if (!snapshot.hasData) {
                return Center(child: Text('loi du lieu'));
              }
              var data1 = snapshot.data!.data() as Map<String, dynamic>;
              show = data1['vui'];
              show1 = data1['id'];
              return Center(child: Text('$show \n ${show1 ?? 'no sql'}'));
            },
          ),
          SizedBox(height: 20),
          Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.6),
                  const Color.fromARGB(255, 239, 97, 147).withOpacity(0.6),
                  const Color.fromARGB(255, 244, 198, 125).withOpacity(0.6),
                  const Color.fromARGB(255, 149, 248, 111).withOpacity(0.5),
                  const Color.fromARGB(255, 4, 141, 246).withOpacity(0.4),
                  const Color.fromARGB(255, 89, 0, 205).withOpacity(0.3),
                  const Color.fromARGB(255, 255, 232, 164).withOpacity(0.4),
                ],
                begin: AlignmentGeometry.topLeft,
                end: AlignmentGeometry.topRight,
              ),
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: const Color.fromARGB(66, 84, 205, 246),
                  offset: Offset(2, 2),
                  spreadRadius: 5,
                ),
              ],
            ),
            child: InkWell(
              onTap: () => add(),
              splashColor: const Color.fromARGB(255, 17, 1, 106).withOpacity(1),
              highlightColor: const Color.fromARGB(
                255,
                99,
                1,
                97,
              ).withOpacity(1),
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.withOpacity(0.6),
                      const Color.fromARGB(255, 239, 97, 147).withOpacity(0.6),
                      const Color.fromARGB(255, 244, 198, 125).withOpacity(0.6),
                      const Color.fromARGB(255, 149, 248, 111).withOpacity(0.5),
                      const Color.fromARGB(255, 4, 141, 246).withOpacity(0.4),
                      const Color.fromARGB(255, 89, 0, 205).withOpacity(0.3),
                      const Color.fromARGB(255, 255, 232, 164).withOpacity(0.4),
                    ],
                    begin: AlignmentGeometry.topRight,
                    end: AlignmentGeometry.topLeft,
                  ),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: const Color.fromARGB(66, 84, 205, 246),
                      offset: Offset(2, 2),
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'add firebase',
                    style: TextStyle(
                      color: Colors.white.withOpacity(1),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
