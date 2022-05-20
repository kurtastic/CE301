// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/screens/food_form_screen.dart';
import 'package:i_am_hungary/screens/login_screen.dart';
import 'package:i_am_hungary/screens/request_info_screen.dart';
import 'package:i_am_hungary/screens/user_all_foods.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'package:i_am_hungary/shared/DelegateClass.dart';
import 'package:i_am_hungary/shared/menu_bottom.dart';

class UserAcc extends StatefulWidget {
  Mongo_db database;

  UserAcc(this.database);

  @override
  State<UserAcc> createState() => _UserAccState();
}

class _UserAccState extends State<UserAcc> {
  List<Widget> foodList = <Widget>[];
  User user = User.empty();

  @override
  void initState() {
    super.initState();
    initFoodList();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MenuBottom(),
      appBar: AppBar(
        title: Text(user.getTitle(),
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: requesterOrGiver()),
      ),
    );
  }

  void initFoodList() async {
    List<Widget> foods = await widget.database.getFoods(user.getId(), context);
    setState(() {
      this.foodList = foods;
    });
  }

  void initUser() async {
    var temp = await widget.database.getLogged();

    setState(() {
      user = temp;
    });
  }

  Widget userTypeDisplay() {
    return user.getType == true
        ? SliverPersistentHeader(
            delegate: Delegate(
                Color.fromARGB(239, 255, 255, 255), 'Food  Available', 28),
            pinned: false,
            floating: false,
          )
        : SliverPersistentHeader(
            delegate: Delegate(
                Color.fromARGB(239, 255, 255, 255), 'Foods Available', 28),
            pinned: false,
            floating: false,
          );
  }

  List<Widget> requesterOrGiver() {
    if (user.getType()) {
      //true = giver false = requester

      return <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ListTile(
            title: Center(
                child: Text(
              "Share new food",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FoodForm(widget.database)),
              );
            },
            //trailing: Icon(Icons.more_vert), FoodForm
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ListTile(
            title: Center(
                child: Text(
              "View your Foods",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserFoods(user, widget.database)),
              );
            },
            //trailing: Icon(Icons.more_vert), UserFoods
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ListTile(
            title: Center(
                child: Text(
              "Requests",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RequestInfo(widget.database)),
              );
            },
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ListTile(
            title: Center(
                child: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login(widget.database)),
              );

              widget.database.logOff();
            },
          ),
        ),
      ];
    } else
      return <Widget>[
        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ListTile(
            title: Center(
                child: Text(
              "Food Requests",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RequestInfo(widget.database)),
              );
            },
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 10)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
          child: ListTile(
            title: Center(
                child: Text(
              "Log Out",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            )),
            enableFeedback: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login(widget.database)),
              );

              widget.database.logOff();
            },
          ),
        ),
      ];
  }
}
