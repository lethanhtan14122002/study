import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class anh extends StatefulWidget {
  @override
  _anhState createState() => _anhState();
}

class _anhState extends State<anh> {
  dynamic data;
  TextEditingController tan = TextEditingController();
  dynamic Name;
  Timer? time;
  bool isbig = false;

  @override
  void initState() {
    super.initState();
    load();
    animate();
  }

  void animate() {
    time = Timer.periodic(const Duration(seconds: 6), (time) {
      if (mounted) {
        setState(() {
          isbig = !isbig;
        });
      }
    });
  }

  void dispose() {
    super.dispose();
    time?.cancel();
  }

  load() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String name = shared.getString('name') ?? '';
    setState(() {
      Name = name;
    });
  }

  save(String name) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setString('name', name);
    load();
  }

  // lưu ảnh '
  Future<void> takeimage() async {
    final picke = ImagePicker();
    final XFile? pickfile = await picke.pickImage(source: ImageSource.gallery);

    if (pickfile != null) {
      final bytes = await pickfile.readAsBytes();
      String base = base64Encode(bytes);

      SharedPreferences shared = await SharedPreferences.getInstance();
      await shared.setString('image', base);

      setState(() {
        data = base;
      });
    }
  }

  Future<Image> decodeimage(String decode) async {
    final bytes = base64Decode(decode);
    return Image.memory(Uint8List.fromList(bytes));
  }

  Future<void> loadimage() async {
    SharedPreferences sherd = await SharedPreferences.getInstance();
    String? base = sherd.getString('image');
    if (base != null) {
      setState(() {
        data = base;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            color: Colors.red.withOpacity(0.4),

            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 6),
                  curve: Curves.easeInOut,
                  alignment: isbig ? Alignment.topLeft : Alignment.bottomRight,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.blue, Colors.red],
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.withOpacity(0.2),
                        Colors.blue.withOpacity(0.3),
                        Colors.red.withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 4),
                    curve: Curves.bounceInOut,
                    alignment: isbig
                        ? Alignment.topLeft
                        : Alignment.bottomRight,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Colors.purple, Colors.blue, Colors.red],
                        ),
                      ),
                    ),
                  ),
                ),

                Text(
                  'Tên đã lưu : $Name',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                TextField(
                  controller: tan,
                  decoration: InputDecoration(
                    label: Text('Tên ...'),
                    hintText: 'Nhập tên của bạn',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        tan.clear(); // Xóa nội dung khi nhấn icon
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text('SAVE'),
                  onPressed: () => save(tan.text),
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  splashColor: Colors.yellow.withOpacity(1),
                  highlightColor: Colors.blue.withOpacity(1),

                  onTap: () => save(tan.text),

                  child: Container(
                    width: 300,
                    height: 100,
                    margin: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple.withOpacity(0.5),
                          Colors.blue.withOpacity(0.4),
                          Colors.red.withOpacity(0.6),
                          Colors.green.withOpacity(0.4),
                          Colors.white.withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                data != null
                    ? FutureBuilder(
                        future: decodeimage(data),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return snapshot.data!;
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      )
                    : Text('no image'),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('choice image'),
                  onPressed: takeimage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
