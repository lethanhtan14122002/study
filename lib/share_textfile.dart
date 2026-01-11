import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShareTextFile extends StatefulWidget {
  @override
  _ShareTextFileState createState() => _ShareTextFileState();
}

class _ShareTextFileState extends State<ShareTextFile> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller1 = TextEditingController();
  String? name;

  @override
  void initState() {
    super.initState();
    _loaddata(); // Tải dữ liệu khi khởi động
  }

  // Hàm tải dữ liệu từ SharedPreferences
  _loaddata() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String ten = shared.getString('name') ?? ''; // Lấy tên từ SharedPreferences
    setState(() {
      name = ten; // Cập nhật trạng thái để hiển thị tên
    });
  }

  // Hàm lưu dữ liệu vào SharedPreferences
  _savedata(String ten) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    shared.setString('name', ten); // Lưu tên vào SharedPreferences
    _loaddata(); // Tải lại dữ liệu sau khi lưu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tan ax')),
      body: Stack(
        children: [
          Positioned(
            top: 10,

            child: // Hiển thị tên đã lưu
            Text(
              'Tên đã lưu: $name ',
              style: TextStyle(fontSize: 20),
            ),
          ),

          Positioned(
            top: 60,
            width: 300,
            height: 100,
            child: // TextField cho phép người dùng nhập tên mới
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'TAN AX',
                hintText: 'Nhập tên của bạn',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear(); // Xóa nội dung khi nhấn icon
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            width: 300,
            height: 100,
            child: // TextField cho phép người dùng nhập tên mới
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText: 'TAN AX',
                hintText: 'Nhập tên của bạn',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear(); // Xóa nội dung khi nhấn icon
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 150,

            child: // Nút lưu tên
            ElevatedButton(
              onPressed: () {
                String ten = _controller.text; // Lấy tên từ TextField
                _savedata(ten); // Lưu tên vào SharedPreferences
              },
              child: Text('Lưu tên'),
            ),
          ),
        ],
      ),
    );
  }
}
