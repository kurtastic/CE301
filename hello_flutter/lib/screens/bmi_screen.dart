// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hello_flutter/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {


   BmiScreen({ Key? key }) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
    final double fontsize = 18
    String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? weight;
  late List <bool> isSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      drawer: const MenuDrawer(),
      body: Column(children: [
        ToggleButtons(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Metric', style : TextStyle(fontSize: fontsize)),
        ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('Imperial', style : TextStyle(fontSize: fontsize)),
        ),
      ]),
      ]),
      );
  }
}