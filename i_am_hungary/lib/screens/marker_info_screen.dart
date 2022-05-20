import 'package:flutter/material.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

import '../ObjectClasses/userClass.dart';
import '../shared/DelegateClass.dart';

class MarkerInfo extends StatefulWidget {
  late final int id;
  late final Mongo_db database;
  final String title;

  MarkerInfo(this.id, this.title, this.database);

  @override
  State<MarkerInfo> createState() => _MarkerInfoState();
}

class _MarkerInfoState extends State<MarkerInfo> {
  List<Widget> foodList = <Widget>[];
  String? userTitle;
  bool? userType;
  User? user;
  String ButtonText = 'Request for food';

  @override
  void initState() {
    super.initState();
    userTitle = widget.title;
    initUser();
    initFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(246, 226, 226, 226),

      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${widget.id} ${widget.title}',
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


  void initFood() async {
    List<Widget> foods = await widget.database.getFoods(widget.id, context);
    setState(() {
      this.foodList = foods;
    });
  }

  void initUser() async {
    var temp = await widget.database.getUser(widget.id);

    setState(() {
      this.user = temp;
    });
  }

  void getUser(id) async {
    User temp = await widget.database.getUser(widget.id);
    setState(() {
      user = temp;
    });
  }
}





