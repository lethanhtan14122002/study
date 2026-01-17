import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ontap extends StatefulWidget {
  @override
  ontapState createState() => ontapState();
}

class ontapState extends State<ontap> with SingleTickerProviderStateMixin {
  String? luu;
  TextEditingController _controller = TextEditingController();
  TextEditingController text1 = TextEditingController();
  late AnimationController animated;
  late Animation<double> move;
  Color mau = Colors.blue;
  String? anh;

  Future<void> takeimage() async {
    final pick = ImagePicker();
    final XFile? anh1 = await pick.pickImage(source: ImageSource.gallery);

    if (anh1 != null) {
      final type = await anh1.readAsBytes();
      String? byte = base64Encode(type);

      SharedPreferences shared = await SharedPreferences.getInstance();
      await shared.setString('image', byte);
      setState(() {
        anh = byte;
      });
    }
  }

  Future<void> loadimage() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? data = await shared.getString('image') ?? '';
    if (data != null) {
      setState(() {
        anh = data;
      });
    }
  }

  Future<Image> decoimage(String data) async {
    final luu = await base64Decode(data);
    return Image.memory(Uint8List.fromList(luu));
  }

  @override
  void initState() {
    super.initState();
    loadimage();
    load();
    anima();
  }

  nut() {
    setState(() {
      mau = mau == Colors.blue ? Colors.red : Colors.blue;
      ;
    });
  }

  anima() {
    animated = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: false);

    move = Tween<double>(
      begin: 0,
      end: 150,
    ).animate(CurvedAnimation(parent: animated, curve: Curves.easeInOut));
  }

  load() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? data = shared.getString('name') ?? '';
    setState(() {
      luu = data;
    });
  }

  save(String tan) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    await shared.setString('name', tan);
    load();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: ListView(
          children: [
            Stack(
              children: [
                Image.asset('assets/love.jpg', fit: BoxFit.cover),

                Container(
                  margin: EdgeInsets.only(top: 550),
                  child: Column(
                    children: [
                      anh != null
                          ? FutureBuilder<Image>(
                              future: decoimage(anh!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return snapshot.data!;
                                } else {
                                  return CircularProgressIndicator();
                                }
                              },
                            )
                          : Text('khong anh'),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        splashColor: Colors.yellow.withOpacity(1),
                        highlightColor: Colors.blue.withOpacity(1),

                        onTap: () => takeimage(),

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
                    ],
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 150),
                  child: Container(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0.1),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    width: double.infinity,
                    height: 300,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(
                              color:
                                  Colors.red, // Thay đổi màu chữ thành màu đỏ
                              fontSize: 16, // Kích thước chữ
                              fontWeight: FontWeight.bold, // Đặt kiểu chữ đậm
                            ),
                            decoration: InputDecoration(
                              labelText: 'write here',
                              hintText: 'input here',
                              labelStyle: TextStyle(
                                color: Colors.green, // Màu của labelText
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                color: const Color.fromARGB(
                                  255,
                                  16,
                                  16,
                                  16,
                                ).withOpacity(0.5), // Màu của hintText
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    131,
                                    129,
                                    129,
                                  ).withOpacity(0.3),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.blue.withOpacity(0.3),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              // Tạo bóng cho TextField
                              filled: true,
                              fillColor: const Color.fromARGB(
                                255,
                                250,
                                249,
                                249,
                              ).withOpacity(0.2),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),

                              // prefixIcon: Image.asset(
                              //   'assets/love.jpg',
                              //   fit: BoxFit.cover,
                              //   width: 10,
                              //   height: 10,
                              // ),
                              // suffixIcon: IconButton(
                              //   icon: Image.asset(
                              //     'assets/love.jpg',
                              //     fit: BoxFit.cover,
                              //     width: 10,
                              //     height: 10,
                              //   ),
                              //   onPressed: () {},
                              // ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 80),
                          padding: EdgeInsets.all(10),

                          child: TextField(
                            controller: text1,
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                            ),
                            decoration: InputDecoration(
                              labelText: 'input two',
                              hintText: 'input here',
                              labelStyle: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    233,
                                    241,
                                    247,
                                  ).withOpacity(0.3),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    230,
                                    234,
                                    237,
                                  ).withOpacity(0.2),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(
                                    255,
                                    36,
                                    211,
                                    36,
                                  ).withOpacity(0.6),
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 150, left: 60),
                          child: ElevatedButton(
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: const Color.fromARGB(
                            //     255,
                            //     243,
                            //     246,
                            //     249,
                            //   ).withOpacity(0.5),
                            // ),
                            onPressed: () {
                              String tan = _controller.text;
                              save(tan);
                              _controller.clear();
                            },
                            child: Stack(
                              children: <Widget>[
                                AnimatedBuilder(
                                  animation: animated,
                                  builder: (context, child) {
                                    return Positioned(
                                      left: move.value,
                                      child: Container(
                                        width: 10,
                                        height: 10,

                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.purple.withOpacity(0.3),
                                              const Color.fromARGB(
                                                255,
                                                210,
                                                147,
                                                221,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                74,
                                                87,
                                                158,
                                              ).withOpacity(0.4),
                                              const Color.fromARGB(
                                                255,
                                                143,
                                                155,
                                                230,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                219,
                                                231,
                                                152,
                                              ).withOpacity(0.5),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: Colors.black26,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                AnimatedBuilder(
                                  animation: animated,
                                  builder: (context, child) {
                                    return Positioned(
                                      bottom: move.value,
                                      child: Container(
                                        width: 10,
                                        height: 10,

                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.purple.withOpacity(0.3),
                                              const Color.fromARGB(
                                                255,
                                                210,
                                                147,
                                                221,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                74,
                                                87,
                                                158,
                                              ).withOpacity(0.4),
                                              const Color.fromARGB(
                                                255,
                                                143,
                                                155,
                                                230,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                219,
                                                231,
                                                152,
                                              ).withOpacity(0.5),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: Colors.black26,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                AnimatedBuilder(
                                  animation: animated,
                                  builder: (context, child) {
                                    return Positioned(
                                      top: move.value,
                                      left: 50,
                                      child: Container(
                                        width: 10,
                                        height: 10,

                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.purple.withOpacity(0.3),
                                              const Color.fromARGB(
                                                255,
                                                210,
                                                147,
                                                221,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                74,
                                                87,
                                                158,
                                              ).withOpacity(0.4),
                                              const Color.fromARGB(
                                                255,
                                                143,
                                                155,
                                                230,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                219,
                                                231,
                                                152,
                                              ).withOpacity(0.5),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: Colors.black26,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                AnimatedBuilder(
                                  animation: animated,
                                  builder: (context, child) {
                                    return Positioned(
                                      right: move.value,
                                      top: 30,
                                      child: Container(
                                        width: 10,
                                        height: 10,

                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.purple.withOpacity(0.3),
                                              const Color.fromARGB(
                                                255,
                                                210,
                                                147,
                                                221,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                74,
                                                87,
                                                158,
                                              ).withOpacity(0.4),
                                              const Color.fromARGB(
                                                255,
                                                143,
                                                155,
                                                230,
                                              ).withOpacity(0.5),
                                              const Color.fromARGB(
                                                255,
                                                219,
                                                231,
                                                152,
                                              ).withOpacity(0.5),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 1,
                                              color: Colors.black26,
                                              offset: Offset(0, 0),
                                              spreadRadius: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.blue.withOpacity(0.3),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 220, left: 20),
                          child: Text(
                            'contention $luu ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
