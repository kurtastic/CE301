// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:hello_flutter/screens/intro_screen.dart';

void main(List<String> args) {
  runApp(GlobeApp()); //shows widget you put in the method
}

class GlobeApp extends StatelessWidget {
  // new clas that extends Statelss widget //use stless  to create
  const GlobeApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    // needs to be overided //called when widget is drawn on screen
    return MaterialApp(
        //type of app we are creating //returning a new instance of Material app
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        home: IntroScreen());
  }
}
