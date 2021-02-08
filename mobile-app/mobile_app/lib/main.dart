import 'package:flutter/material.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

bool isPowerOn = false;
String isOpen = "Open", isClosed = "Closed";

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  isPowerOn = false;
                });
              },
              icon: Icon(Icons.lightbulb),
              color: Colors.red,
              iconSize: 80,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isPowerOn = true;
                });
              },
              icon: Icon(Icons.lightbulb_outline),
              color: Colors.green,
              iconSize: 80,
            ),
            isPowerOn
                ? Text(
                    '$isOpen',
                    style: TextStyle(fontSize: 30),
                  )
                : Text(
                    '$isClosed',
                    style: TextStyle(fontSize: 30),
                  ),
          ],
        ),
      ),
    );
  }
}
