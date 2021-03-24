import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/utils/apiData.dart';
import 'api_models/status.dart';
import 'screens/splashscreen.dart';

void main() {
  runApp(MaterialApp(
    home: SplashScreen(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // title: 'SmartBlinds',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
        home: MyHomePage(title: 'SmartBlinds'));
  }
}

//will change later to false since it needs to first get the status and then declare itself true or false
bool isPoweredOn = true; 

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Status> statusFuture;
  bool doCallAPI = false;

  @override
  void initState() {
    super.initState();
    statusFuture = ApiEndpoints.getStatus();
  }

  void _toggleBlindStatus() {
    //check to see if its open or closed
    //call open/close endpoint for blinds
    //update UI, if request was successful

    print("in toggle");
    ApiEndpoints.getStatus().then((fetchedStatusFuture) {
      print("in getStatus");
      String currentStatus = fetchedStatusFuture.status;
      if(currentStatus == "open") {
        // Call close endpoint
        ApiEndpoints.closeBlinds().then((toggleFuture) {
          print("in close");
          setState(() {
            isPoweredOn = false;
            doCallAPI = false;
          });
        });
      } else {
        // Call open endpoint
        ApiEndpoints.openBlinds().then((toggleFuture) {
          isPoweredOn = true;
          doCallAPI = false;
        });
      }
    });
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
                image: isPoweredOn ? 
                NetworkImage("https://cdn.discordapp.com/attachments/780477496797036575/816409571597484062/unknown.png") : 
                NetworkImage("https://cdn.discordapp.com/attachments/780477496797036575/816409670041600000/unknown.png"),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  doCallAPI = true;
                });
                _toggleBlindStatus();
              },
              icon: Icon(Icons.power_settings_new),
              color: isPoweredOn ? Colors.green : Colors.red,iconSize: 80),
            isPoweredOn ?
              Text('Open',style: TextStyle(fontSize: 40, color: Colors.green)) : 
              Text('Closed',style: TextStyle(fontSize: 40, color: Colors.red)),
            SizedBox(height: 80.0),
            FutureBuilder(
              future: statusFuture,
              builder:
                  (BuildContext context, AsyncSnapshot<Status> snapshot) {
                if (snapshot.hasData) {
                  Status status = snapshot.data;
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Status: ${status.status}",
                          style: TextStyle(fontSize: 30, color: Colors.blue))]);
                } else {
                  return Center(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(width: 20.0), 
                        Text("Fetching status...", 
                        style: TextStyle(fontSize: 30, color: Colors.blue))]));
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
