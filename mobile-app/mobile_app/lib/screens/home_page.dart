import 'dart:async';
import 'package:mobile_app/api_models/status.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/utils/apiData.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:mobile_app/config/globals.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiEndpoints api = ApiEndpoints();

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
        setState(() {
          api.currentStatus = BlindStatusStates.Open;
        });
      } else {
        setState(() {
          api.currentStatus = BlindStatusStates.Closed;
        });
      }
    }).catchError((exception) {
      print(exception);
      setState(() {
        api.currentStatus = BlindStatusStates.Failure;
      });
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
      }).catchError((exception) {
        print(exception);
        setState(() {
          api.currentStatus = BlindStatusStates.Failure;
        });
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
      }).catchError((exception) {
        print(exception);
        setState(() {
          api.currentStatus = BlindStatusStates.Failure;
        });
      });
    }
  }

  String getStateText() {
    switch(api.currentStatus) {
      case BlindStatusStates.Open: {
        return "open";
      }
      break;

      case BlindStatusStates.InProgress: {
        return "working on it...";
      }
      break;

      case BlindStatusStates.Closed: {
        return "closed";
      }
      break;

      case BlindStatusStates.Failure: {
        return "failed - try again";
      }
      break;
    }
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
        actions: []
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
                    image: AssetImage(api.currentStatus == BlindStatusStates.Open ? "assets/opened.png" : "assets/closed.png"),
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
                      : Text('${getStateText()}', style: TextStyle(fontSize: 40, color: Colors.red))
                  )
                ]
              )
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
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
  }
}
