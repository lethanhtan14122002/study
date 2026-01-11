import 'dart:convert'; // Để mã hóa Base64
import 'dart:typed_data'; // Để sử dụng các kiểu dữ liệu byte
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  String? _base64Image;

  // Hàm chọn ảnh và lưu vào SharedPreferences
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      // Mã hóa ảnh thành chuỗi Base64
      final bytes = await pickedFile.readAsBytes();
      String base64Image = base64Encode(bytes);

      // Lưu Base64 vào SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('image', base64Image);

      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  // Hàm giải mã Base64 và trả về dữ liệu ảnh
  Future<Image> _decodeImageFromBase64(String base64Str) async {
    final bytes = base64Decode(base64Str);
    return Image.memory(Uint8List.fromList(bytes));
  }

  @override
  void initState() {
    super.initState();
    _loadImage(); // Tải ảnh từ SharedPreferences khi ứng dụng khởi động
  }

  // Hàm tải ảnh từ SharedPreferences
  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? base64Image = prefs.getString('image');

    if (base64Image != null) {
      setState(() {
        _base64Image = base64Image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chọn ảnh và lưu vào SharedPreferences')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Nếu có ảnh, hiển thị ảnh đã giải mã
            _base64Image != null
                ? FutureBuilder<Image>(
                    future: _decodeImageFromBase64(_base64Image!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return snapshot.data!;
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  )
                : Text('Chưa có ảnh'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Chọn ảnh từ thư viện'),
            ),
          ],
        ),
      ),
    );
  }
}
