import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/utils/apiData.dart';
import 'package:mobile_app/config/globals.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


class HomePage extends StatefulWidget {
  ApiEndpoints api;

  HomePage(this.api);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // getCurrentStatus();
    // getCurrentPercent();
  }

  String setBackgroundText() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return "assets/opened.png";
      }
      break;

      case BlindStatusStates.InProgress: {
        return "assets/SmartBlindsTransparent.png";  // make into loading gif
      }
      break;

      case BlindStatusStates.Closed: {
        return "assets/closed.png";
      }
      break;

      case BlindStatusStates.Failure: {
        return "assets/noConnection.jpg";
      }
      break;

      default: {
        return "assets/SmartBlinds.png"; // make into loading gif
      }
      break;
    }
  }

  void getCurrentPercent() {
    // Send request to get current percent
    Future<int> percentFuture = ApiEndpoints.getPercent(httpClient);

    // Update status based on result
    percentFuture.then((value) {
      setState(() {
        widget.api.currentPercentage = value;
      });
    }).catchError((exception) {
      print(exception);
      setState(() {
        widget.api.currentStatus = BlindStatusStates.Failure;
        widget.api.currentPercentage = 0;
      });
    });
  }

  void getCurrentStatus() {
    // Send request to get status
    Future<String> statusFuture = ApiEndpoints.getStatus(httpClient);

    // Update status based on result
    statusFuture.then((value) {
      if(value == "open") {
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Open;
        });
      } else {
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Closed;
        });
      }
    }).catchError((exception) {
      print(exception);
      setState(() {
        widget.api.currentStatus = BlindStatusStates.Failure;
      });
    });
  }

  void toggleBlind() {
    if(widget.api.currentStatus == BlindStatusStates.Open) {
      // Send request to close
      Future<String> closeFuture = ApiEndpoints.closeBlinds(httpClient);

      // Update status to in progress
      setState(() {
        widget.api.currentStatus = BlindStatusStates.InProgress;
      });

      // Update status based on result
      closeFuture.then((value) {
        if(value == "opened") {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Open;
          });
        } else {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Closed;
          });
        }
      }).catchError((exception) {
        print(exception);
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Failure;
        });
      });
    } else {
      // Send request to open
      Future<String> openFuture = ApiEndpoints.openBlinds(httpClient);

      // Update status to in progress
      setState(() {
        widget.api.currentStatus = BlindStatusStates.InProgress;
      });

      // Update status based on result
      openFuture.then((value) {
        if(value == "opened") {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Open;
          });
        } else {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Closed;
          });
        }
      }).catchError((exception) {
        print(exception);
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Failure;
        });
      });
    }
  }

  void moveToPercentage(int percent) {
      // Send request to move to percent
      Future<String> openFuture = ApiEndpoints.moveToPercentage(httpClient, percent);

      // Update status to in progress
      setState(() {
        widget.api.currentStatus = BlindStatusStates.InProgress;
      });

      // Update status based on result
      openFuture.then((value) {
        if(value == "opened") {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Open;
          });
        } else {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Closed;
          });
        }

        // Update current percentage
        setState(() {
          widget.api.currentPercentage = percent;
        });
      }).catchError((exception) {
        print(exception);
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Failure;
        });
      });
  }

  String getStateText() {
    switch(widget.api.currentStatus) {
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

  IconButton setStatusIcon() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return IconButton(icon: Icon(Icons.public, color: Colors.green, size: 20));
      }
      break;

      case BlindStatusStates.InProgress: {
        return IconButton(icon: Icon(Icons.hourglass_empty_outlined, color: Colors.blue, size: 20));
      }
      break;

      case BlindStatusStates.Closed: {
        return IconButton(icon: Icon(Icons.public, color: Colors.green, size: 20));
      }
      break;

      case BlindStatusStates.Failure: {
        return IconButton(icon: Icon(Icons.public_off, color: Colors.red, size: 20));
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("SmartBlinds"),
        backgroundColor: Colors.grey[850],
        elevation: 4.0,
        actions: [ setStatusIcon()
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
                    image: AssetImage(setBackgroundText()),
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
                    child: SleekCircularSlider(
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
                        size: 250
                      ),
                      initialValue: widget.api.currentPercentage == null ? 0 : widget.api.currentPercentage.toDouble(),
                      onChangeEnd: (double value) {
                        //PENDING: Sending Value to API
                        print(value);
                      }
                    )
                  ),
                  Container(
                    height: 115,
                    child: IconButton(
                      onPressed: () {
                        toggleBlind();
                      },
                      icon: Icon(Icons.power_settings_new),
                      color: widget.api.currentStatus == BlindStatusStates.Open ? Colors.green : Colors.red,
                      iconSize: 80
                    ),
                  ),
                  Container(
                    height: 38,
                    child: widget.api.currentStatus == BlindStatusStates.Open
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
