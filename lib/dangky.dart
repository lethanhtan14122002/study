import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:thunail/ontap.dart';
import 'ontap2.dart';
import 'dart:convert';

class dangky extends StatefulWidget {
  @override
  dangkyState createState() => dangkyState();
}

class dangkyState extends State<dangky> {
  final FirebaseFirestore fire = FirebaseFirestore.instance;
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  bool obscure = true;

  Future<QuerySnapshot> load() async {
    return await fire.collection('register').get();
  }

  Future<void> add(String name, password) async {
    try {
      String hashedPassword = _hashPassword(
        password,
      ); // Mã hóa mật khẩu trước khi lưu
      await fire.collection('register').add({
        'name': name,
        'password': password,
      });
    } catch (e) {
      print('loi : $e');
    }
  }

  bool isValidPassword(String password) {
    // Biểu thức chính quy kiểm tra chữ hoa, số và ký tự đặc biệt
    RegExp regex = RegExp(
      r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return regex.hasMatch(password);
  }

  // Mã hóa mật khẩu bằng SHA-256
  String _hashPassword(String password) {
    var bytes = utf8.encode(password); // Chuyển chuỗi thành byte
    var digest = sha256.convert(bytes); // Băm mật khẩu
    return digest.toString(); // Trả về chuỗi băm
  }

  Future<bool> isUsernameTaken(String name) async {
    // Kiểm tra xem tên tài khoản đã tồn tại trong Firebase chưa
    QuerySnapshot snapshot = await fire
        .collection('register')
        .where('name', isEqualTo: name)
        .get();
    return snapshot.docs.isNotEmpty; // Trả về true nếu tài khoản đã tồn tại
  }

  Future<void> kiemtra(String name, String mk, String mk1) async {
    try {
      if (mk == mk1) {
        if (isValidPassword(mk)) {
          if (mk.length >= 8) {
            bool user = await isUsernameTaken(name);
            if (user) {
              add(name, mk);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ontap2()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tên tài khoản đã tồn tại !')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('mật khẩu phải có độ dài 8 ký tự ')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'phải có 1 chữ hoa , 1 chữ thường , 1 số , 1 ký tự đặc biệt',
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('password dose not match')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('lỗi : $e')));
    }
    // if (mk == mk1) {
    //   if (isValidPassword(mk)) {
    //     // Kiểm tra tên tài khoản đã tồn tại hay chưa
    //     bool usernameTaken = await isUsernameTaken(name);
    //     if (usernameTaken) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(
    //           content: Text('Tên tài khoản đã tồn tại. Vui lòng chọn tên khác'),
    //         ),
    //       );
    //     } else {
    //       String? password = mk;
    //       await add(name, password);
    //       ScaffoldMessenger.of(
    //         context,
    //       ).showSnackBar(SnackBar(content: Text('Đăng ký thành công')));
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => ontap2()),
    //       );
    //     }
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text('Mật khẩu phải có chữ hoa, số và ký tự đặc biệt'),
    //       ),
    //     );
    //   }
    // } else {
    //   ScaffoldMessenger.of(
    //     context,
    //   ).showSnackBar(SnackBar(content: Text('Mật khẩu không khớp')));
    // }
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.5),
          ),
          child: Column(
            children: [
              TextField(
                controller: c1,
                decoration: InputDecoration(
                  labelText: 'Nhập tên tài khoản',
                  hintText: 'Nhập tài khoản ...',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: c2,
                decoration: InputDecoration(
                  labelText: 'Nhập mật khẩu',
                  hintText: 'Nhập mật khẩu ...',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure = !obscure;
                      });
                    },
                    icon: Icon(
                      obscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                obscureText: obscure, // ẩn mk
                obscuringCharacter: '😅', // thay ký tự ẩn *
              ),
              TextField(
                controller: c3,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu',
                  hintText: 'Nhập lại mật khẩu ...',
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  String? t1 = c1.text;
                  String? t2 = c2.text;
                  String? t3 = c3.text;
                  kiemtra(t1, t2, t3);
                },
                child: Center(child: Text('save')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
