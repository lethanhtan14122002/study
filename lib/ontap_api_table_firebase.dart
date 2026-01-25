import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ontap3 extends StatefulWidget {
  @override
  ontap3State createState() => ontap3State();
}

class tator {
  int id;
  String title;
  tator({required this.id, required this.title});
}

class ontap3State extends State<ontap3> {
  late Future<List<tator>> tan;

  Future<List<tator>> load() async {
    final reponse = await http.get(
      Uri.parse(
        'https://boitarot.com.vn/wp-json/wp/v2/tarot1la_meaning?per_page=100&page=1&status=publish&tarot1la_topic=116&_fields=id,content,tarot1la_card_id,tarot1la_orientation',
      ),
    );

    if (reponse.statusCode == 200) {
      var data = json.decode(reponse.body);

      List<tator> mang = [];
      for (var i in data) {
        mang.add(tator(id: i['id'], title: i['content']['rendered']));
      }
      return mang;
    } else {
      throw Exception('loi lay du lieu');
    }
  }

  @override
  void initState() {
    super.initState();
    tan = load();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('api_table_firebase')),
      body: FutureBuilder<List<tator>>(
        future: tan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Center(child: Text('loi ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: Text('loi data'));
          }
          var luu = snapshot.data!;
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,

                child: Table(
                  border: TableBorder.all(
                    width: 3,
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                  columnWidths: {
                    0: FixedColumnWidth(100),
                    1: FixedColumnWidth(500),
                  },
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(15),
                            child: Text('id'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(15),
                            child: Text('title'),
                          ),
                        ),
                      ],
                    ),
                    for (var item in luu)
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(15),
                              child: Text('${item.id}'),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: EdgeInsetsGeometry.all(15),
                              child: Text(item.title),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
