import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class them extends StatefulWidget {
  @override
  randomState createState() => randomState();
}

class randomState extends State<them> {
  final FirebaseFirestore fire = FirebaseFirestore.instance;
  TextEditingController controller = TextEditingController();

  Future<QuerySnapshot> getdata() async {
    return await fire.collection('add').get();
  }

  Future<void> update(String id, String titel) async {
    try {
      await fire.collection('add').doc(id).update({
        'tiltle': titel,
        'time': FieldValue.serverTimestamp(),
      });
      setState(() {});
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  Future<void> delete(String id) async {
    try {
      await fire.collection('add').doc(id).delete();
      setState(() {});
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase')),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height:
                400, // Đã thay đổi chiều cao để có không gian hiển thị tốt hơn
            child: FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('Không có dữ liệu'));
                }

                var data1 = snapshot.data!.docs;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Table(
                    border: TableBorder.all(
                      width: 2,
                      color: Colors.red.withOpacity(0.3),
                      style: BorderStyle.solid,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    columnWidths: {
                      0: FixedColumnWidth(150),
                      1: FixedColumnWidth(200),
                      2: FixedColumnWidth(200),
                    },
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('ID'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('title'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text('update-delete'),
                            ),
                          ),
                        ],
                      ),
                      ...data1.map<TableRow>((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        var id = doc.id;
                        return TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('$id'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text('${data['tiltle']}'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.text = data['tiltle'];
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('update'),
                                              content: TextField(
                                                controller: controller,
                                                decoration: InputDecoration(
                                                  hintText: 'tan',
                                                  labelText: 'tan hi',
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    update(id, controller.text);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('save'),
                                                ),
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text('cancel'),
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
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
