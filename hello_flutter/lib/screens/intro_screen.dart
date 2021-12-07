// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:hello_flutter/shared/menu_drawer.dart';
import '../shared/menu_bottom.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            //charactersitics of material app //container widget//create basic layeout structure fro other widgets
            appBar: AppBar(title: Text('Globo Fitness')), //Application bar created in scaffold with text Global fitness
            drawer: MenuDrawer(),
            bottomNavigationBar: MenuBottom(),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image1.jpg'),
                        fit: BoxFit.cover)),
                child: Center(
                    child: Container(
                  padding: EdgeInsets.all(24), //ditance of all sides of container for padding
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20)), // sets corners to round
                    color: Colors.white70,
                  ),
                  child: Text('Commit to be great with\n Globo Fitness',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 2.0,
                          color: Colors.grey,
                        )
                      ])),
                ))));
  }
}

