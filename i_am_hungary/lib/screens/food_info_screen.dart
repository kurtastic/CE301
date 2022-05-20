// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:i_am_hungary/ObjectClasses/foodClass.dart';
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/screens/user_account_screen.dart';
import 'package:i_am_hungary/shared/menu_bottom.dart';

class FoodInfo extends StatefulWidget {
  Food food;
  User user;
  FoodInfo(this.food, this.user);

  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  String _userId = ("");
  String _foodTitle = ("");
  String _foodDesc = ("");
  String _exprDate = ("");
  String _allergens = ("");
  bool _collected = false;
  bool _status = false;

  @override
  void initState() {
    super.initState();
    _userId = widget.food.getUserId().toString();
    _foodTitle = widget.food.getFoodTitle();
    _foodDesc = widget.food.getFoodDesc();
    _exprDate =
        "${widget.food.getExpr().day.toString()}/${widget.food.getExpr().month}/${widget.food.getExpr().year}";
    _allergens = widget.food.getAllergens().toString();
    _collected = widget.food.getCollected();
    _status = widget.food.getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MenuBottom(),
      appBar: AppBar(
        title: Text(
          _foodTitle,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: requesterOrGiver()),
      ),
    );
  }

  List<Widget> requesterOrGiver() {
    if (widget.user.getType() && widget.food.getUserId()==widget.user.getId()) {
      //true = giver false = requester

      return <Widget>[
        Card(
          child: ListTile(
            title: Text("Expiration:"),
            trailing: Text(_exprDate),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("User in possesion:"),
            trailing: Text(widget.user.getUsername()),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Description:'),
            subtitle: Text(' $_foodDesc'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Allergens present'),
            trailing: Text(_allergens),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Collected'),
            trailing: Text("$_collected"),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Container(
            child: ElevatedButton(
              child: Text('Delete Food'),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Confirm Deletion'),
                    content: Text('Remove food from database'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.food
                              .getDatabase()
                              .removeFood(widget.food.getId());
                          Navigator.pop(context, 'OK');
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UserAcc(widget.food.getDatabase()),
                            ),
                          );

                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ];
    } else if (!widget.user.getType() && widget.food.getStatus() == false) {
      return <Widget>[
        Card(
          child: ListTile(
            title: Text("Expiration:"),
            trailing: Text(_exprDate),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("User in possesion:"),
            trailing: Text(_userId),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Description:'),
            subtitle: Text(' $_foodDesc'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Allergens present'),
            trailing: Text(_allergens),
          ),
        ),
         Card(
          child: ListTile(
            title: Text('Requested'),
            trailing: Text("$_status"),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Collected'),
            trailing: Text("$_collected"),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: Container(
            child: ElevatedButton(
              child: Text('Request'),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Confirm Request'),
                    content: Text('Send request to user $_userId'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.food.getDatabase().sendRequests(
                              widget.user.getId(),
                              int.parse(_userId),
                              widget.food.getId());
                          widget.food.setStatus();
                          Navigator.pop(context, 'OK');
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ];
    } else
      return <Widget>[
        Card(
          child: ListTile(
            title: Text("Expiration:"),
            trailing: Text(_exprDate),
          ),
        ),
        Card(
          child: ListTile(
            title: Text("User in possesion:"),
            trailing: Text(_userId),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Description:'),
            subtitle: Text(' $_foodDesc'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Allergens present'),
            trailing: Text(_allergens),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('Requested'),
            trailing: Text("$_status"),
          ),
        ),
         Card(
          child: ListTile(
            title: Text('Collected'),
            trailing: Text("$_collected"),
          ),
        ),
      ];
  }
}
