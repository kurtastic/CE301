// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'package:i_am_hungary/shared/DelegateClass.dart';
import 'package:i_am_hungary/shared/menu_bottom.dart';

class UserAccR extends StatefulWidget {
  Mongo_db database;

  UserAccR(this.database);

  @override
  State<UserAccR> createState() => _UserAccRState();
}

class _UserAccRState extends State<UserAccR> {
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
      backgroundColor: Color.fromARGB(246, 226, 226, 226),
      bottomNavigationBar: MenuBottom(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                user.getTitle(),
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: Delegate(
                Color.fromARGB(239, 255, 255, 255), 'Your Food Requests ', 25),
            pinned: false,
            floating: false,
          ),
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildListDelegate(
              foodList,
            ),
          ),
        ],
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  //backgroundColor: Color.fromARGB(255, 33, 150, 243),
                  //textColor: Colors.white,
                  ),
              child: Text('Request for food'),
            ),
          ),
        ],
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
                Color.fromARGB(239, 255, 255, 255), 'Food Available', 28),
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
}
