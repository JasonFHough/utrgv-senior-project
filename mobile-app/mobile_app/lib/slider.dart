import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Slider extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

Class _SliderState extends State<Slider>{
  var sliderValue = 0.0;
  IconData feedback = FontAwesomeIcons.sun;
  Color feedbackColor = Colors.yellow;

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      title: Text("Smart Blinds"),

    )
  }
}