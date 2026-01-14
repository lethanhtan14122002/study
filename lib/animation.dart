// import 'dart:async';

// import 'package:flutter/material.dart';

// class animated extends StatefulWidget {
//   @override
//   _animatedState createState() => _animatedState();
// }

// class _animatedState extends State<animated> {
//   bool isbig = true;
//   Timer? time;
//   // double _size = 100;
//   // Color _color = Colors.red;

//   @override
//   void initState() {
//     super.initState();
//     animate();
//   }

//   void animate() {
//     time = Timer.periodic(const Duration(seconds: 6), (time) {
//       if (mounted) {
//         setState(() {
//           isbig = !isbig;
//           // _size = _size == 100 ? 200 : 100;
//           // _color = _color == Colors.red ? Colors.blue : Colors.red;
//         });
//       }
//     });
//   }

//   void dispose() {
//     time?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('animated example')),
//       body: Container(
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//         margin: EdgeInsets.all(20),
//         alignment: Alignment.center,
//         width: double.infinity,
//         height: double.infinity,

//         child: AnimatedPositioned(
//           alignment: isbig ? Alignment.centerLeft : Alignment.bottomCenter,
//           duration: const Duration(seconds: 1),
//           curve: Curves.easeInOut,
//           color: Colors.red.withOpacity(0.4),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50),
//               color: isbig ? Colors.red : Colors.blue,
//             ),
//             width: 40,
//             height: 50,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';

class animeted extends StatefulWidget {
  @override
  animateState createState() => animateState();
}

class animateState extends State<animeted> {
  int isbig = 5;
  Timer? time;

  @override
  void initState() {
    super.initState();
    load();
  }

  void dispose() {
    super.dispose();
    time?.cancel();
  }

  void load() {
    time = Timer.periodic(const Duration(milliseconds: 204), (time) {
      if (mounted) {
        setState(() {
          if (isbig < 250) {
            isbig += 5;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: isbig.toDouble(),

            // Di chuyển từ 50 đến 150
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.red,
              ),
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
