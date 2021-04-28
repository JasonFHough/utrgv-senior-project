import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_app/utils/apiData.dart';
import 'package:mobile_app/config/globals.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
//import 'package:mobile_app/utils/functions.dart';


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
    
    // In the event the status and percents failed to load
    // during the splash screen, try one more time
    if(widget.api.currentStatus == BlindStatusStates.Failure) {
      getCurrentStatus();
      getCurrentPercent();
    }
  }

  String setBackgroundText() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return "assets/opened.png";
      }
      break;

      case BlindStatusStates.InProgress: {
        return "assets/loading.gif"; 
        //return "assets/SmartBlindsTransparent.png";  // make into loading gif
      }
      break;

      case BlindStatusStates.Closed: {
        return "assets/closed.png";
      }
      break;

      case BlindStatusStates.Failure: {
        return "assets/noConnection.jpg";
        //return "assets/loading.gif";
      }
      break;

      default: {
        return "assets/loading.gif";
        //return "assets/SmartBlinds.png";  // make into loading gif
      }
      break;
    }
  }

  String setStateText() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return "Open";
      }
      break;

      case BlindStatusStates.InProgress: {
        return "Working on it...";
      }
      break;

      case BlindStatusStates.Closed: {
        return "Closed";
      }
      break;

      case BlindStatusStates.Failure: {
        return "Offline - Try again";
      }
      break;
    }
  }

  Text setStatusText() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return Text('${setStateText()}', style: TextStyle(fontSize: 35, color: Colors.green));
      }
      break;

      case BlindStatusStates.InProgress: {
        return Text('${setStateText()}', style: TextStyle(fontSize: 35, color: Colors.blue));
      }
      break;

      case BlindStatusStates.Closed: {
        return Text('${setStateText()}', style: TextStyle(fontSize: 35, color: Colors.red));
      }
      break;

      case BlindStatusStates.Failure: {
        return Text('${setStateText()}', style: TextStyle(fontSize: 35, color: Colors.red[900]));
      }
      break;
    }
  }

  Color setStatusButtonColor() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return Colors.green;
      }
      break;

      case BlindStatusStates.InProgress: {
        return Colors.blue;
      }
      break;

      case BlindStatusStates.Closed: {
        return Colors.red;
      }
      break;

      case BlindStatusStates.Failure: {
        return Colors.red[900];
      }
      break;
    }
  }

  IconButton setAppbarStatusIcon() {
    switch(widget.api.currentStatus) {
      case BlindStatusStates.Open: {
        return IconButton(icon: Icon(Icons.public, color: Colors.green, size: 20), onPressed: null);
      }
      break;

      case BlindStatusStates.InProgress: {
        return IconButton(icon: Icon(Icons.hourglass_empty_outlined, color: Colors.blue, size: 20), onPressed: null);
      }
      break;

      case BlindStatusStates.Closed: {
        return IconButton(icon: Icon(Icons.public, color: Colors.green, size: 20), onPressed: null);
      }
      break;

      case BlindStatusStates.Failure: {
        return IconButton(icon: Icon(Icons.public_off, color: Colors.red, size: 20), onPressed: null);
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
    Future<String> moveToPercentageFuture = ApiEndpoints.moveToPercentage(httpClient, percent);

    // Update status to in progress
    setState(() {
      widget.api.currentStatus = BlindStatusStates.InProgress;
    });

    // Update status based on result
    moveToPercentageFuture.then((value) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("SmartBlinds", textAlign: TextAlign.center),
        backgroundColor: Colors.grey[850],
        elevation: 4.0,
        actions: [ setAppbarStatusIcon()
        ]
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(setBackgroundText()),
                    fit: BoxFit.scaleDown
                  )
                )
              )
            ),
            Builder(
              builder: (BuildContext context) {
                // If status is currently in progress, display a progress indicator
                if(widget.api.currentStatus == BlindStatusStates.InProgress) {
                  return CircularProgressIndicator();
                } else {
                  return Container();
                }
              }
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
                        size: 250,
                        infoProperties: InfoProperties(
                          topLabelText: "testing"
                        )
                      ),
                      initialValue: widget.api.currentPercentage == null ? 0 : widget.api.currentPercentage.toDouble(),
                      onChangeEnd: (double value) {
                        moveToPercentage(value.toInt());
                      }
                    )
                  ),
                  Container(
                    height: 100,
                    child: IconButton(
                      onPressed: () {
                        toggleBlind();
                      },
                      icon: Icon(Icons.power_settings_new),
                      color: setStatusButtonColor(),
                      iconSize: 80
                    ),
                  ),
                ]
              )
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 40,
                child: setStatusText()
              )
            )
          ]
        )
      )
    );
  }
}
