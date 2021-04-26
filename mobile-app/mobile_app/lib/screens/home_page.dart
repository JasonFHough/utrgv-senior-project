import 'dart:async';
import 'package:mobile_app/api_models/status.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/utils/apiData.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:mobile_app/config/globals.dart';

//will change later to false since it needs to first get the status and then declare itself true or false
bool isPoweredOn = false, isOnline = false;
String openedBlinds = 'https://cdn.discordapp.com/attachments/780477496797036575/816409571597484062/unknown.png',
      closedBlinds = 'https://cdn.discordapp.com/attachments/780477496797036575/816409670041600000/unknown.png';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiEndpoints api = ApiEndpoints();

  bool doCallAPI = false;

  @override
  void initState() {
    super.initState();
    getCurrentStatus();
  }

  void getCurrentStatus() {
    // Send request to get status
    Future<String> statusFuture = ApiEndpoints.getStatus(httpClient);

    // Update status based on result
    statusFuture.then((value) {
      if(value == "open") {
        api.currentStatus = BlindStatusStates.Open;
      } else {
        api.currentStatus = BlindStatusStates.Closed;
      }
    });
  }

  void toggleBlind() {
    if(api.currentStatus == BlindStatusStates.Open) {
      // Send request to close
      Future<String> closeFuture = ApiEndpoints.closeBlinds(httpClient);

      // Update status to in progress
      setState(() {
        api.currentStatus = BlindStatusStates.InProgress;
      });

      // Update status based on result
      closeFuture.then((value) {
        if(value == "opened") {
          setState(() {
            api.currentStatus = BlindStatusStates.Open;
          });
        } else {
          setState(() {
            api.currentStatus = BlindStatusStates.Closed;
          });
        }
      });
    } else {
      // Send request to open
      Future<String> openFuture = ApiEndpoints.openBlinds(httpClient);

      // Update status to in progress
      setState(() {
        api.currentStatus = BlindStatusStates.InProgress;
      });

      // Update status based on result
      openFuture.then((value) {
        if(value == "opened") {
          setState(() {
            api.currentStatus = BlindStatusStates.Open;
          });
        } else {
          setState(() {
            api.currentStatus = BlindStatusStates.Closed;
          });
        }
      });
    }
  }

  String getStateText() {
    if(api.currentStatus == BlindStatusStates.Open) {
      return "open";
    } else if(api.currentStatus == BlindStatusStates.InProgress) {
      return "working on it...";
    } else {
      return "closed";
    }
  }

  /*
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
      } else if (currentStatus == "closed") {
        // Call open endpoint
        ApiEndpoints.openBlinds().then((toggleFuture) {
         print("in open");
          setState(() {
            isPoweredOn = true;
            doCallAPI = false;
          });
        });
      }});
  }
  */

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
        shadowColor: Colors.white,
        shadowStep: 5
      ),
      size:250
    ),
    initialValue: 55, // PENDING: Get current state of blinds
    onChange: (double value) {
      //PENDING: Sending Value to API
      //print(value);
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("SmartBlinds"),
        backgroundColor: Colors.grey[850],
        elevation: 4.0,
        actions: [
          IconButton(
            icon: isOnline ? Icon(Icons.public, color: Colors.green, size: 20)
            : Icon(Icons.public_off,color: Colors.red, size: 20), 
            onPressed: null,
          )
        ]
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: api.currentStatus == BlindStatusStates.Open ? NetworkImage(openedBlinds) : NetworkImage(closedBlinds),
                    fit: BoxFit.scaleDown
                  )
                )
              )
            ),
            Expanded(
              flex: 4,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Container(
                    height: 230,
                    child: slider1,
                  ),
                  Container(
                    height: 115,
                    child: IconButton(
                      onPressed: () {
                        toggleBlind();
                        /*
                        setState(() {
                          doCallAPI = true;
                        });
                        _toggleBlindStatus();
                        */
                      },
                      icon: Icon(Icons.power_settings_new),
                      color: api.currentStatus == BlindStatusStates.Open ? Colors.green : Colors.red,
                      iconSize: 80
                    ),
                  ),
                  Container(
                    height: 38,
                    child: api.currentStatus == BlindStatusStates.Open
                      ? Text('Open', style: TextStyle(fontSize: 40, color: Colors.green))
                      : Text('Closed', style: TextStyle(fontSize: 40, color: Colors.red))
                  )
                ]
              )
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  // Text("Status: ${status.status}",
                  // Text("${status.status}",
                  Text(
                    "${getStateText()}",
                    style: TextStyle(fontSize: 30, color: Colors.blue)
                  )
                ]
              )
            )
          ]
        )
      )
    );
              /*
              FutureBuilder(
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
                          // Text("${status.status}",
                          Text("Status should go here",
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
                  }}))])));
              */
  }
}
