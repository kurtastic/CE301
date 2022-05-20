// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/screens/login_screen.dart';
import 'package:i_am_hungary/screens/user_account_screen.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'screens/gmap_screen.dart';

import 'package:i_am_hungary/screens/welcome_screen.dart';

void main(List<String> args) {
  runApp(HungryApp()); //shows widget you put in the method
}

class HungryApp extends StatefulWidget {
  // new clas that extends Statelss widget //use stless  to create
  const HungryApp({Key? key}) : super(key: key);

  @override
  State<HungryApp> createState() => _HungryAppState();
}

class _HungryAppState extends State<HungryApp> {
  Mongo_db database = Mongo_db();
  User? loggedIn;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  initDatabase() async {
    var temp = await database.initConnection();
    setState(() {
      database = temp;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,

        scaffoldBackgroundColor: Color.fromRGBO(226, 226, 226, 1),
        canvasColor: Color.fromARGB(63, 226, 226, 226),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.green,
            unselectedItemColor: Colors.white,
            selectedItemColor: Colors.white),

        fontFamily: 'RobotoMono-VariableFont_wght',

      ),

      routes: {
        '/': (context) => IntroScreen(),
        '/gmap': (context) => Gmap(database),
        '/login': (context) => Login(database),
        '/user': (context) => UserAcc(database),
      },
      initialRoute: '/login',
    );
  }
}
