import 'package:flutter/material.dart';
import 'package:mobile_app/screens/splashscreen.dart';
import 'package:mobile_app/utils/apiData.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  ApiEndpoints api = ApiEndpoints();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SmartBlinds',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(api),
    );
  }
}