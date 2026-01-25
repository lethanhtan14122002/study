import 'package:flutter/material.dart';

class ontap2 extends StatefulWidget {
  @override
  ontap2State createState() => ontap2State();
}

class ontap2State extends State<ontap2> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animated;
  late Animation<double> animated1;
  late Animation<double> animated2;
  late AnimationController controller1;

  late Animation<double> size;
  //textfield
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();

  void load() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    animated = Tween<double>(
      begin: 0,
      end: 110,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    animated1 = Tween<double>(
      begin: 0,
      end: 170,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward();
  }

  void size1() {
    controller1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat(reverse: false);
    animated2 = Tween<double>(
      begin: 0,
      end: 150,
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut));
    size = Tween<double>(
      begin: 5,
      end: 15,
    ).animate(CurvedAnimation(parent: controller1, curve: Curves.easeInOut));
  }

  @override
  void initState() {
    super.initState();
    load();
    size1();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 640,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Stack(
                  children: [
                    Positioned(
                      right: animated.value,
                      child: Image.asset(
                        'assets/2.jpg',
                        height: 640,
                        width: 250,
                      ),
                    ),
                    Positioned(
                      left: animated.value,
                      child: Image.asset(
                        'assets/1.jpg',
                        height: 640,
                        width: 250,
                      ),
                    ),
                    Positioned(
                      bottom: animated1.value,
                      // top: 180,
                      left: 12,
                      child: Container(
                        width: 301,
                        height: 300,

                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            254,
                            253,
                            253,
                          ).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.all(10),
                              // decoration: BoxDecoration(
                              //   gradient: LinearGradient(
                              //     colors: [
                              //       Colors.red.withOpacity(0.5),
                              //       Colors.blue.withOpacity(0.4),
                              //       Colors.green.withOpacity(0.5),
                              //       Colors.purple.withOpacity(0.4),
                              //       Colors.red.withOpacity(0.4),
                              //       Colors.blue.withOpacity(0.4),
                              //       Colors.green.withOpacity(0.5),
                              //       Colors.purple.withOpacity(0.6),
                              //     ],
                              //     begin: Alignment.topLeft,
                              //     end: Alignment.bottomRight,
                              //   ),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.black.withOpacity(0.6),
                              //       offset: Offset(2, 2),
                              //       blurRadius: 4.0,
                              //       spreadRadius: 4.2,
                              //     ),
                              //   ],
                              // ),
                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: c1,
                                  decoration: InputDecoration(
                                    hintText: 'Nhập tên vào đây ...',
                                    labelText: 'Nhập tên',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                          255,
                                          92,
                                          71,
                                          71,
                                        ).withOpacity(0.4),
                                        width: 2,
                                        style: BorderStyle.solid,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        width: 4,
                                        color: Colors.white.withOpacity(0.7),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.5),

                                    hintStyle: TextStyle(),
                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.all(10),

                              child: SingleChildScrollView(
                                child: TextField(
                                  controller: c2,
                                  decoration: InputDecoration(
                                    hintText: 'Nhập mật khẩu vào đây ...',
                                    labelText: 'Nhập mật khẩu',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Colors.white.withOpacity(0.6),
                                        width: 2,
                                        style: BorderStyle.solid,
                                      ),
                                    ),

                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        width: 4,
                                        color: Colors.white.withOpacity(0.8),
                                        style: BorderStyle.solid,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.5),

                                    hintStyle: TextStyle(),
                                    labelStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.8),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(
                                    0.9,
                                  ),
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadiusGeometry.circular(30),
                                  // )
                                ),
                                onPressed: () {},
                                child: Container(
                                  // color: Colors.blue.withOpacity(0.5),
                                  child: AnimatedBuilder(
                                    animation: controller1,
                                    builder: (context, child) {
                                      return Stack(
                                        children: [
                                          Positioned(
                                            bottom: 30,
                                            left: animated2.value,
                                            child: Container(
                                              width: size.value,
                                              height: size.value,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.red.withOpacity(0.5),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.red.withOpacity(0.4),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.6,
                                                    ),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            right: animated2.value,
                                            child: Container(
                                              width: size.value,
                                              height: size.value,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.red.withOpacity(0.5),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.red.withOpacity(0.4),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.6,
                                                    ),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 45,
                                            top: animated2.value,
                                            child: Container(
                                              width: size.value,
                                              height: size.value,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.red.withOpacity(0.5),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.red.withOpacity(0.4),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.6,
                                                    ),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            right: 45,
                                            bottom: animated2.value,
                                            child: Container(
                                              width: size.value,
                                              height: size.value,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.red.withOpacity(0.5),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.red.withOpacity(0.4),
                                                    Colors.blue.withOpacity(
                                                      0.4,
                                                    ),
                                                    Colors.green.withOpacity(
                                                      0.5,
                                                    ),
                                                    Colors.purple.withOpacity(
                                                      0.6,
                                                    ),
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                            ),
                                          ),

                                          Positioned(
                                            child: Text(
                                              'save',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
