// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:i_am_hungary/shared/menu_bottom.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key("hungryAppBar"),
        title: Text(
          'I am Hungry App',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MenuBottom(
        key: Key('menuBottom'),
      ),
      body: Container(
        key: Key('image'),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white70,
            ),
            child: Text(
                'Lets help tackle climate change and foodwaste by sharing Food\n\nClick Map to start\n↓',
                textAlign: TextAlign.center,
                key: Key('welcomeMessage'),
                style: TextStyle(
                    fontSize: 30,
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 2.0,
                        color: Colors.grey,
                      )
                    ],
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}
