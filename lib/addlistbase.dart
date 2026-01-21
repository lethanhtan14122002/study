import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addlist extends StatefulWidget {
  @override
  addlistState createState() => addlistState();
}

class addlistState extends State<addlist> {
  final FirebaseFirestore fire = FirebaseFirestore.instance;
  TextEditingController controler = TextEditingController();

  Future<QuerySnapshot> getdata() async {
    return await fire.collection('tan').get();
  }

  Future<void> add() async {
    try {
      await fire.collection('tan').add({
        'value': 'h',
        'vui': 'tan',
        'time': FieldValue.serverTimestamp(),
      });
      setState(() => fire);
    } catch (e) {
      print('loi $e');
    }
  }

  save(String text) async {
    try {
      await fire.collection('tan').add({
        'vui': text,
        'time': FieldValue.serverTimestamp(),
      });
      setState(() {
        fire;
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
      appBar: AppBar(title: Text('get firebase')),
      body: Container(
        child: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              child: FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  if (!snapshot.hasData) {
                    return Center(child: Text('loi'));
                  }
                  var t = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: t.length,
                    itemBuilder: (context, index) {
                      var luu = t[index].data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text('name : ${t[index].id}'),
                        subtitle: Text('data : ${luu['vui'] ?? 'NO'}'),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => add(), child: Text('save')),
            TextField(
              controller: controler,
              decoration: InputDecoration(
                labelText: 'write here',
                hintText: 'input name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                var text = controler.text;
                controler.clear();
                save(text);
              },
              child: Text('save'),
            ),
          ],
        ),
      ),
    );
  }
}
