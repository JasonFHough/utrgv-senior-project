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
  double _sliderValue;
  String _blindImagePath;
  // NOTE: To make the background image seem fluid during sliding the slider,
  // use a string variable representing the image path to show and then have it
  // update in onChange.

  @override
  void initState() {
    super.initState();

    // In the event the status and percents failed to load
    // during the splash screen, try one more time
    if(widget.api.currentStatus == BlindStatusStates.Failure) {
      getCurrentStatus();
      getCurrentPercent();
    }

    _sliderValue = widget.api.currentPercentage.toDouble();
    setBackgroundText();
  }

  String setBackgroundText() {
    setState(() {
      switch(widget.api.currentStatus) {
        case BlindStatusStates.Open: {
          _blindImagePath = "assets/opened.png";
        }
        break;

        case BlindStatusStates.InProgress: {
          // Don't change image unless for whatever reason there wasn't an image assigned previously
          if(_blindImagePath == null) {
            _blindImagePath = "assets/closed.png";
          }
        }
        break;

        case BlindStatusStates.Closed: {
          _blindImagePath = "assets/closed.png";
        }
        break;

        case BlindStatusStates.Failure: {
          _blindImagePath = "assets/noConnection.jpg";
        }
        break;

        default: {
          _blindImagePath = "assets/loading.gif";
        }
        break;
      }
    });
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
        _sliderValue = value.toDouble();
      });
    }).catchError((exception) {
      print(exception);
      setState(() {
        widget.api.currentStatus = BlindStatusStates.Failure;
        widget.api.currentPercentage = 0;
        _sliderValue = 0.0;
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

      setBackgroundText();
    }).catchError((exception) {
      print(exception);
      setState(() {
        widget.api.currentStatus = BlindStatusStates.Failure;
      });
      setBackgroundText();
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
            widget.api.currentPercentage = 50;
          });
        } else {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Closed;
            widget.api.currentPercentage = 0;
          });
        }

        _sliderValue = widget.api.currentPercentage.toDouble();
        setBackgroundText();
      }).catchError((exception) {
        print(exception);
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Failure;
          widget.api.currentPercentage = 0;
          _sliderValue = widget.api.currentPercentage.toDouble();
        });
        setBackgroundText();
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
            widget.api.currentPercentage = 50;
          });
        } else {
          setState(() {
            widget.api.currentStatus = BlindStatusStates.Closed;
            widget.api.currentPercentage = 0;
          });
        }

        _sliderValue = widget.api.currentPercentage.toDouble();
        setBackgroundText();
      }).catchError((exception) {
        print(exception);
        setState(() {
          widget.api.currentStatus = BlindStatusStates.Failure;
          widget.api.currentPercentage = 0;
          _sliderValue = widget.api.currentPercentage.toDouble();
        });
        setBackgroundText();
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

      setBackgroundText();

      // Update current percentage
      setState(() {
        widget.api.currentPercentage = percent;
        _sliderValue = percent.toDouble();
      });
    }).catchError((exception) {
      print(exception);
      setState(() {
        widget.api.currentStatus = BlindStatusStates.Failure;
        _sliderValue = widget.api.currentPercentage.toDouble();
        setBackgroundText();
      });
    });
  }

  void sliderOnChangeAction(double newValue) {
    setState(() {
      _sliderValue = newValue;
    });
  }

  void buttonOnPressedAction() {
    toggleBlind();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("SmartBlinds", textAlign: TextAlign.center),
        backgroundColor: Colors.grey[800],
        elevation: 4.0,
        actions: [setAppbarStatusIcon()]
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              children: <Widget> [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget> [
                      Text(
                        "${_sliderValue.round()} %",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[50]
                        )
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.grey[50],
                            inactiveTrackColor: Colors.grey[800],
                            trackShape: RectangularSliderTrackShape(),
                            trackHeight: 4.0,
                            thumbColor: Colors.grey,
                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                            overlayColor: Colors.grey.withAlpha(32),
                            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                          ),
                          child: Slider(
                            value: _sliderValue,
                            min: 0,
                            max: 100,
                            label: '${_sliderValue.round()} %',
                            onChanged: widget.api.currentStatus == BlindStatusStates.InProgress ? null : (double newValue) => sliderOnChangeAction(newValue),
                            onChangeEnd: (double newValue) {
                              moveToPercentage(newValue.round());
                            }
                          ),
                        ),
                      )
                    ]
                  )
                ),
                Expanded(
                  flex: 8,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget> [
                      Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Image.asset(_blindImagePath, fit: BoxFit.scaleDown)
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
                      )
                    ]
                  )
                )
              ]
            ),
            Column(
              children: <Widget> [
                Container(
                  child: IconButton(
                    onPressed: widget.api.currentStatus == BlindStatusStates.InProgress ? null : () => buttonOnPressedAction(),
                    icon: Icon(Icons.power_settings_new),
                    color: setStatusButtonColor(),
                    iconSize: 80
                  ),
                ),
                Container(
                  child: setStatusText()
                )
              ]
            )
          ]
        )
      )
    );
  }
}