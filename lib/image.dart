import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class anh extends StatefulWidget {
  @override
  anhState createState() => anhState();
}

class anhState extends State<anh> {
  @override
  void initSate() {
    super.initState();
  }

  dynamic tan;
  Future<void> takeimage() async {
    final pick = ImagePicker();
    final XFile? vip = await pick.pickImage(source: ImageSource.gallery);

    if (vip != null) {
      final base = await vip.readAsBytes();
      String tan1 = base64Encode(base);
      SharedPreferences share = await SharedPreferences.getInstance();
      await share.setString('Image', tan1);
      setState(() {
        tan = tan1; // Cập nhật lại giá trị của tan
      });
    }
  }

  Future<Image> giai(String giai1) async {
    final giai2 = await base64Decode(giai1);
    return Image.memory(Uint8List.fromList(giai2));
  }

  Future<void> load() async {
    SharedPreferences share = await SharedPreferences.getInstance();
    String? vip1 = await share.getString('Image');
    if (vip1 != null) {
      setState(() {
        tan = vip1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          tan != null
              ? FutureBuilder(
                  future: giai(tan!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data!;
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              : Text('khong co anh'),
          ElevatedButton(onPressed: takeimage, child: Text('anh')),
        ],
      ),
    );
  }
}
