import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'SmartBlinds',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'SmartBlinds'));
  }
}

bool isPowerOn = false;
String openedBlinds =
        "https://cdn.discordapp.com/attachments/780477496797036575/816399238161236008/IMG_5469.PNG", //Discord app is apparently required to show image so opted to upload to a imgage uploader
    //"https://ibb.co/9GKwjT8",
    closedBlinds =
        "https://cdn.discordapp.com/attachments/780477496797036575/816399238224937000/IMG_5468.PNG";
//"https://ibb.co/Myv8SS2";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> getStatus() async {
    var response = await http.get(
        Uri.encodeFull("http://csci4390.ddns.net/api/v1/blind/status"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer jason-token'
        });
    //List data = json.decode(response.body);
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      //print(data[0]['status']);
    } else {
      print('HTTP Status Code: ${response.statusCode}');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        width: 500.0,
        height: 700.0,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: isPowerOn
                    ? NetworkImage(
                        "https://cdn.discordapp.com/attachments/780477496797036575/816409571597484062/unknown.png")
                    : NetworkImage(
                        "https://cdn.discordapp.com/attachments/780477496797036575/816409670041600000/unknown.png"),
                // image: ,
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () {
                  setState(() {
                    isPowerOn = !isPowerOn;
                  });
                  getStatus();
                },
                icon: Icon(Icons.power_settings_new),
                color: isPowerOn ? Colors.green : Colors.red,
                iconSize: 80),
            isPowerOn
                ? Text('Open',
                    style: TextStyle(fontSize: 40, color: Colors.green))
                : Text('Closed',
                    style: TextStyle(fontSize: 40, color: Colors.red)),
            SizedBox(height: 50.0),
            Text("Status: ",
                style: TextStyle(fontSize: 30, color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
