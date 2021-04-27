import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/screens/home_page.dart';
import 'package:mobile_app/utils/apiData.dart';
import 'package:mobile_app/config/globals.dart';

class SplashScreen extends StatefulWidget {
  ApiEndpoints api;

  SplashScreen(this.api);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    waitForAPI();
  }

  void navigateToDeviceScreen() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => HomePage(widget.api)));
  }

  Future<int> getCurrentPercent(ApiEndpoints api) async {
    // Send request to get current percent
    Future<int> percentFuture = ApiEndpoints.getPercent(httpClient);
    return percentFuture;
  }

  Future<String> getCurrentStatus(ApiEndpoints api) async {
    // Send request to get status
    Future<String> statusFuture = ApiEndpoints.getStatus(httpClient);
    return statusFuture;
  }

  void waitForAPI() async {
    try {
      // Submit API requests to get the current status and percent
      String status = await getCurrentStatus(widget.api);
      int percent = await getCurrentPercent(widget.api);

      // After the requests finish, update instance variables to keep state for UI
      if(status == "open") {
        widget.api.currentStatus = BlindStatusStates.Open;
      } else if(status == "closed") {
        widget.api.currentStatus = BlindStatusStates.Closed;
      } else {
        widget.api.currentStatus = BlindStatusStates.Failure;
      }

      widget.api.currentPercentage = percent;
    } catch(exception) {
      // Exceptions would be thrown by the two await functions
      print(exception);

      widget.api.currentStatus = BlindStatusStates.Failure;
      widget.api.currentPercentage = 0;

      // Wait an extra 2 seconds for some nice splash screen effect
      await Future.delayed(Duration(seconds: 2));
    }

    // Once instance variables are set, navigate to the home screen
    navigateToDeviceScreen();
  }
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      //backgroundColor: Color(0xffFFFFFF),
      backgroundColor: Color(0xff000000),
      //backgroundColor: Color(0xff696969), //dimgrey
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/SmartBlindsLogoCropped.gif')
          ]
        )
      )
    );
  }
}