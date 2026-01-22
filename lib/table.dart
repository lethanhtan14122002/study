import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class them extends StatefulWidget {
  @override
  themxoasuaState createState() => themxoasuaState();
}

class themxoasuaState extends State<them> {
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
      setState(() {});
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
      setState(() {});
    } catch (e) {
      print('e : $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await fire.collection('add').doc(id).delete();
      setState(() {});
    } catch (e) {
      print('e : $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add, Update, Delete')),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400,
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder(
              future: load(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No Data Available'));
                }

                var data = snapshot.data!.docs;
                return SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: data.map<DataRow>((doc) {
                      var base = doc.data() as Map<String, dynamic>;
                      var id = doc.id;
                      return DataRow(
                        cells: [
                          DataCell(Text(id)),
                          DataCell(Text(base['tiltle'])),
                          DataCell(
                            Row(
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
                                              hintText: 'Write here',
                                              labelText: 'Update Title',
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
                                              child: Center(
                                                child: Text('Save'),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Center(
                                                child: Text('Cancel'),
                                              ),
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
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Title',
                hintText: 'Here comes the title',
                border: OutlineInputBorder(),
              ),
            ),
          ),
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
