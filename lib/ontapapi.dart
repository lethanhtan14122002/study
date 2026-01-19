import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Ontapapi extends StatefulWidget {
  @override
  ontaoState createState() => ontaoState();
}

class tan {
  final int id;
  final String title;
  tan({required this.id, required this.title});
}

class ontaoState extends State<Ontapapi> {
  late Future<List<tan>> vip;

  void initState() {
    super.initState();
    vip = laod();
  }

  Future<List<tan>> laod() async {
    final response = await http.get(
      Uri.parse(
        'https://boitarot.com.vn/wp-json/wp/v2/tarot1la_meaning?per_page=100&page=1&status=publish&tarot1la_topic=118&_fields=id,content,tarot1la_card_id,tarot1la_orientation',
      ),
    );

    if (response.statusCode == 200) {
      //chuyen doi json thanh list
      var data = json.decode(response.body);
      //tao mang them mang
      List<tan> tan1 = [];

      for (var i in data) {
        tan1.add(tan(id: i['id'], title: i['content']['rendered']));
      }

      return tan1;
    } else {
      throw Exception('no sql');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tan')),
      body: FutureBuilder(
        future: vip,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var luu = snapshot.data!;
            return ListView.builder(
              itemCount: luu.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(luu[index].title),
                  subtitle: Text(luu[index].id.toString()),
                );
              },
            );
          } else {
            return Center(child: Text('khong co'));
          }
        },
      ),
    );
  }
}
