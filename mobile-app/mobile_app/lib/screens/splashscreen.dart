import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobile_app/main.dart';

// import 'package:homebrew_dripper/screens/recipe_selection_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 5);
    return Timer(duration, navigateToDeviceScreen);
  }

  navigateToDeviceScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => MyApp()));
  }
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Color(0xff696969), //dimgrey
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("SmartBlinds",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: Color(0xffffffff),
                  letterSpacing: 0.1,
                )),
                SizedBox(height: 20),
            Text("Blinds, but more smarter.",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xffffffff)))
          ],
        ),
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff4C748B), //517082 4C748B
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("HOMEBREW",
//                 style: TextStyle(
//                   fontSize: 48,
//                   fontWeight: FontWeight.w400,
//                   fontFamily: 'norwester',
//                   color: Color(0xffffffff),
//                   letterSpacing: 0.1,
//                 )),
//             //height: 57.6)),
//             Text("Handmade Coffee",
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontFamily: 'Kollektif',
//                     color: Color(0xffffffff)))
//           ],
//         ),
//       ),
//     );
//   }
// }