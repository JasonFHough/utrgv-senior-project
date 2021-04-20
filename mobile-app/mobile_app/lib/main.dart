import 'dart:async';
import 'api_models/status.dart';

import 'package:flutter/material.dart';
import 'package:mobile_app/apiData.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'SmartBlinds'));
  }
}

//will change later to false since it needs to first get the status and then declare itself true or false
bool isPoweredOn = false, isOnline = false, isDark = false, isHot = true;
String openedBlinds = 'https://cdn.discordapp.com/attachments/780477496797036575/816409571597484062/unknown.png',
      closedBlinds = 'https://cdn.discordapp.com/attachments/780477496797036575/816409670041600000/unknown.png';

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

  //slider widget  
  SleekCircularSlider slider1 = SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                        customColors: CustomSliderColors(
                            trackColor: Colors.black,
                            progressBarColors: [
                              Colors.black,
                              Colors.blue[400],
                              //Colors.grey
                            ],
                            shadowMaxOpacity: 1,
                            shadowColor: Colors.deepPurple[900],
                            shadowStep: 5),
                        // infoProperties:
                        //     InfoProperties(topLabelText: isPoweredOn ? 'Open' : 'Closed'),
                        size: 250),
                    initialValue: 55, // PENDING: Get current state of blinds
                    onChange: (double value) {
                      //PENDING: Sending Value to API
                      //print(value);
                    });

  void _toggleBlindStatus() {
    //check to see if its open or closed
    //call open/close endpoint for blinds
    //update UI, if request was successful

    print("in toggle");
    ApiEndpoints.getStatus().then((fetchedStatusFuture) {
      print("in getStatus");
      String currentStatus = fetchedStatusFuture.status;
      if (currentStatus == "open") {
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey[850],
        elevation: 4.0,
        actions: [
          IconButton(
            icon: isOnline ? Icon(Icons.public,
                color: Colors.green, size: 20): Icon(Icons.public_off,
                color: Colors.red, size: 20), // PENDING: Functionality
            //Icons.public_off apiconnected = false
            //Icons.public apiconnected = true
            onPressed: null,
          ),
          IconButton(
            icon: isDark ? Icon(Icons.nightlight_round,
                color: Colors.white, size: 20) : Icon(Icons.wb_sunny,
                color: Colors.amber[400], size: 20), // PENDING: Functionality
            //Icons.nightlight_round lightSensor = false
            //Icons.wb_sunny lightSensor = true
            onPressed: null,
          ),
          IconButton(
            icon: isHot ? Icon(Icons.thermostat_rounded,
                color: Colors.red, size: 20): Icon(Icons.thermostat_rounded,
                color: Colors.lightBlue, size: 20), // PENDING: Functionality
            //Colors.red  = temp hot
            //Colors.orange  = temp warm
            //Colors.lightBlue = temp cold
            onPressed: null,
          ),
        ],
        //leading: Icon(Icons.home_rounded),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: isPoweredOn ? NetworkImage(openedBlinds) : NetworkImage(closedBlinds),
                      fit: BoxFit.scaleDown)))),
            Expanded(
              flex: 4,
              child: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 300,
                  child: slider1,
                ),
                Container(
                  height: 150,
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          doCallAPI = true;
                        });
                        _toggleBlindStatus();
                      },
                      icon: Icon(Icons.power_settings_new),
                      color: isPoweredOn ? Colors.green : Colors.red,
                      iconSize: 80),
                ),
                //SizedBox(height: 20.0),
                isPoweredOn
                    ? Text('Open',
                        style: TextStyle(fontSize: 40, color: Colors.green))
                    : Text('Closed',
                        style: TextStyle(fontSize: 40, color: Colors.red)),
              ],
            ),
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder(
                future: statusFuture,
                builder:
                    (BuildContext context, AsyncSnapshot<Status> snapshot) {
                  if (snapshot.hasData) {
                    Status status = snapshot.data;
                    isOnline = true;
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //Text("Status: ${status.status}",
                          Text("${status.status}",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.blue))
                        ]);
                  } else {
                    isOnline = false;
                    return Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                          CircularProgressIndicator(),
                          // SizedBox(width: 20.0),
                          // Text("Fetching status...",
                          //     style:
                          //         TextStyle(fontSize: 30, color: Colors.blue))
                        ]));
                  }
                }),
            ),
            
          ],
        ),
      ),
    );
  }
}
