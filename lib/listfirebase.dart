import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class listfirebase extends StatefulWidget {
  @override
  listfirebaseState createState() => listfirebaseState();
}

class listfirebaseState extends State<listfirebase> {
  final FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<QuerySnapshot> listdata() async {
    return await firebase.collection('tan').get();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('firebaselist')),
      body: FutureBuilder(
        future: listdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text('erro: ${snapshot.hasError}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('no firebase data'));
          }
          var dulieu = snapshot.data!.docs;

          return ListView.builder(
            itemCount: dulieu.length,
            itemBuilder: (context, index) {
              var data = dulieu[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text('id: ${dulieu[index].id}'),
                subtitle: Text('${data['vui'] ?? 'no data'}'),
              );
            },
          );
        },
      ),
    );
  }
}
