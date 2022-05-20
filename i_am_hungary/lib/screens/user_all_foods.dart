import 'package:flutter/material.dart';
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

import '../shared/DelegateClass.dart';

// ignore: must_be_immutable
class UserFoods extends StatefulWidget {
  Mongo_db database;
  User user;
  UserFoods(this.user, this.database, {Key? key}) : super(key: key);

  @override
  State<UserFoods> createState() => _UserFoodsState();
}

class _UserFoodsState extends State<UserFoods> {
  var foodList = <Widget>[];

  @override
  void initState() {
    super.initState();
    initfoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // alignment: Alignment.center,
      // decoration: BoxDecoration(
      backgroundColor: Color.fromARGB(246, 226, 226, 226),

      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${widget.user.getTitle()}',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: Delegate(
                Color.fromARGB(239, 255, 255, 255), 'Foods Available', 28),
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
    );
  }


  void initfoods() async {
    List<Widget> foods =
        await widget.database.getFoods(widget.user.getId(), context);
    setState(() {
      this.foodList = foods;
    });
  }
}
