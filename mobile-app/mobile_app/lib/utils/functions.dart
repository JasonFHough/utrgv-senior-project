//import 'dart:async';
//import 'package:mobile_app/config/globals.dart';
//import 'package:sleek_circular_slider/sleek_circular_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_app/utils/apiData.dart';
// import 'package:mobile_app/screens/home_page.dart';



// String getStateText() {
//     switch(api.currentStatus) {
//       case BlindStatusStates.Open: {
//         return "Open";
//       }
//       break;

//       case BlindStatusStates.InProgress: {
//         return "Working on it...";
//       }
//       break;

//       case BlindStatusStates.Closed: {
//         return "Closed";
//       }
//       break;

//       case BlindStatusStates.Failure: {
//         return "Offline - Try again";
//       }
//       break;
//     }
//   }

//   Text setStatusText() {
//     switch(widget.api.currentStatus) {
//       case BlindStatusStates.Open: {
//         return Text('${getStateText()}', style: TextStyle(fontSize: 35, color: Colors.green));
//       }
//       break;

//       case BlindStatusStates.InProgress: {
//         return Text('${getStateText()}', style: TextStyle(fontSize: 35, color: Colors.blue));
//       }
//       break;

//       case BlindStatusStates.Closed: {
//         return Text('${getStateText()}', style: TextStyle(fontSize: 35, color: Colors.red));
//       }
//       break;

//       case BlindStatusStates.Failure: {
//         return Text('${getStateText()}', style: TextStyle(fontSize: 35, color: Colors.white));
//       }
//       break;
//     }
//   }

//   Color setStatusButtonColor() {
//     switch(widget.api.currentStatus) {
//       case BlindStatusStates.Open: {
//         return Colors.green;
//       }
//       break;

//       case BlindStatusStates.InProgress: {
//         return Colors.blue;
//       }
//       break;

//       case BlindStatusStates.Closed: {
//         return Colors.red;
//       }
//       break;

//       case BlindStatusStates.Failure: {
//         return Colors.white;
//       }
//       break;
//     }
//   }

//   IconButton setAppbarStatusIcon() {
//     switch(widget.api.currentStatus) {
//       case BlindStatusStates.Open: {
//         return IconButton(icon: Icon(Icons.public, color: Colors.green, size: 20), onPressed: null);
//       }
//       break;

//       case BlindStatusStates.InProgress: {
//         return IconButton(icon: Icon(Icons.hourglass_empty_outlined, color: Colors.blue, size: 20), onPressed: null);
//       }
//       break;

//       case BlindStatusStates.Closed: {
//         return IconButton(icon: Icon(Icons.public, color: Colors.green, size: 20), onPressed: null);
//       }
//       break;

//       case BlindStatusStates.Failure: {
//         return IconButton(icon: Icon(Icons.public_off, color: Colors.red, size: 20), onPressed: null);
//       }
//       break;
//     }
//   }