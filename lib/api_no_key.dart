import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Class đại diện cho 1 lá bài Tarot với id và title
class TarotCard {
  final int id;
  final String title;

  TarotCard({required this.id, required this.title});
}

class TarotCardScreen extends StatefulWidget {
  @override
  _TarotCardScreenState createState() => _TarotCardScreenState();
}

class _TarotCardScreenState extends State<TarotCardScreen> {
  late Future<List<TarotCard>> tarotCards;

  @override
  void initState() {
    super.initState();
    tarotCards = fetchData();
  }

  Future<List<TarotCard>> fetchData() async {
    final response = await http.get(
      Uri.parse(
        'https://boitarot.com.vn/wp-json/wp/v2/tarot1la_card?per_page=100&page=1&orderby=title&order=asc&_fields=id,title',
      ),
    );

    if (response.statusCode == 200) {
      // Chuyển đổi dữ liệu JSON thành List
      var data = json.decode(response.body);

      // Tạo một List chứa các đối tượng TarotCard
      List<TarotCard> cardList = [];
      for (var item in data) {
        // Thêm id và title vào danh sách
        cardList.add(
          TarotCard(
            id: item['id'], // Lấy id
            title: item['title']['rendered'], // Lấy title
          ),
        );
      }

      return cardList;
    } else {
      throw Exception('Không thể tải dữ liệu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarot Cards')),
      body: FutureBuilder<List<TarotCard>>(
        future: tarotCards,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var tarotCardsList = snapshot.data!;
            return ListView.builder(
              itemCount: tarotCardsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tarotCardsList[index].title),
                  subtitle: Text('ID: ${tarotCardsList[index].id}'),
                );
              },
            );
          } else {
            return Center(child: Text('Không có dữ liệu'));
          }
        },
      ),
    );
  }
}
