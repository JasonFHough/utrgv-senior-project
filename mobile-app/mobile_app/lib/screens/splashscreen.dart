//import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mobile_app/main.dart';

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
      backgroundColor: Color(0xffFFFFFF),
      //backgroundColor: Color(0xff000000),
      //backgroundColor: Color(0xff696969), //dimgrey
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Image.asset('assets/Smart_Bliends.jpg')
            //Image.asset('assets/Smart_Bliends_transparent.jpg'),
            //Smart_Bliends_transparent.jpg
            // Text("SmartBlinds",
            //     style: TextStyle(
            //       fontSize: 48,
            //       fontWeight: FontWeight.w400,
            //       color: Color(0xffffffff),
            //       letterSpacing: 0.1,
            //     )),
            //     SizedBox(height: 20),
            // Text("Blinds, but more smarter.",
            //     style: TextStyle(
            //         fontSize: 18,
            //         color: Color(0xffffffff)))
          ])));
  }}