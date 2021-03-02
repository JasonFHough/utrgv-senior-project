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
      home: MyHomePage(title: 'SmartBlinds'),
    );
  }
}

bool isPowerOn = false;
String openedBlinds =
        "https://cdn.discordapp.com/attachments/780477496797036575/816399238161236008/IMG_5469.PNG",
    closedBlinds =
        "https://cdn.discordapp.com/attachments/780477496797036575/816399238224937000/IMG_5468.PNG";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> getTestStatus() async {
    var response = await http.get(
        Uri.encodeFull("http://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    //print(response.body);

    List data = json.decode(response.body);

    print(data[1]['title']);
  }

  Future<String> getStatus() async {
    var response = await http.get(
        Uri.encodeFull("http://csci4390.ddns.net/api/v1/blind/status"),
        headers: {"Accept": "application/json"});

    List data = json.decode(response.body);

    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  isPowerOn = !isPowerOn;
                });
                getTestStatus();
                //getStatus();
              },
              icon: Icon(Icons.power_settings_new),
              color: isPowerOn ? Colors.green : Colors.red,
              iconSize: 80,
            ),
            isPowerOn
                ? Text(
                    'Open',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.green,
                      /*backgroundColor: Colors.white*/
                    ),
                  )
                : Text(
                    'Closed',
                    style: TextStyle(fontSize: 40, color: Colors.red),
                  ),
            SizedBox(
              width: 50.0,
              height: 50.0,
            ),
            Text(
              'Status: ',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
