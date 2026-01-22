import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class themxoasua extends StatefulWidget {
  @override
  themxoasuaState createState() => themxoasuaState();
}

class themxoasuaState extends State<themxoasua> {
  TextEditingController controller = TextEditingController();
  final FirebaseFirestore fire = FirebaseFirestore.instance;

  Future<QuerySnapshot> load() async {
    return await fire.collection('add').get();
  }

  Future<void> add(String tan) async {
    try {
      await fire.collection('add').add({
        'tiltle': tan,
        'time': FieldValue.serverTimestamp(),
      });
      setState(() {
        fire;
      });
    } catch (e) {
      print('e : $e');
    }
  }

  Future<void> update(String id, String newTitle) async {
    try {
      await fire.collection('add').doc(id).update({
        'tiltle': newTitle,
        'time': FieldValue.serverTimestamp(),
      });
      setState(() {
        fire;
      });
    } catch (e) {
      print('e : $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await fire.collection('add').doc(id).delete();
      setState(() {
        fire;
      });
    } catch (e) {
      print('e : $e');
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
      appBar: AppBar(title: Text('add update clear ')),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 200,

            child: FutureBuilder(
              future: load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Center(child: Text('loi ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('no data'));
                }
                var data = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var base = data[index].data() as Map<String, dynamic>;
                    var id = data[index].id;
                    return ListTile(
                      title: Text('id : ${id}'),
                      subtitle: Text('title: ${base['tiltle']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              controller.text = base['tiltle'];
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Update Data'),
                                    content: TextField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        hintText: 'write here',
                                        labelText: 'update title',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          update(id, controller.text);
                                          controller.clear();
                                          Navigator.pop(context);
                                        },
                                        child: Center(child: Text('save')),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Center(child: Text('Cancel')),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () => delete(id),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: ('write here'),
              hintText: ('here come'),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              var tan = controller.text;
              controller.clear();
              add(tan);
            },
            child: Center(child: Text('Save')),
          ),
        ],
      ),
    );
  }
}
