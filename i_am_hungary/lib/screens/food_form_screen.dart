import 'package:flutter/material.dart';
import 'package:i_am_hungary/ObjectClasses/foodClass.dart';
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'package:toggle_switch/toggle_switch.dart';

// ignore: must_be_immutable
class FoodForm extends StatefulWidget {
  Mongo_db database;
  FoodForm(this.database, {Key? key}) : super(key: key);

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  String _title = "Share new food";
  //TextEditingController _userIdController = TextEditingController();
  TextEditingController _foodTitleController = TextEditingController();
  TextEditingController _foodDescController = TextEditingController();
  TextEditingController _dayController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  bool _allergens = false;

  User? _user;

  @override
  void initState() {
    super.initState();
    innitUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
              child: TextField(
                controller: _foodTitleController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Food Title',
                ),
                maxLength: 30,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: _foodDescController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Food Description',
                ),
                maxLength: 250,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text("Expiration Date: "),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 2, 0),
                      child: TextField(
                        maxLength: 2,
                        controller: _dayController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Day',
                          hintText: '00',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                      child: TextField(
                        maxLength: 2,
                        controller: _monthController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Month',
                          hintText: '00',
                          hintStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(2, 0, 10, 0),
                      child: TextField(
                        maxLength: 4,
                        controller: _yearController,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Year',
                          hintText: '0000',
                          hintStyle: TextStyle(fontSize: 14),
                          //hintText:
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Allergens Present: "),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: ToggleSwitch(
                      minWidth: 90,
                      initialLabelIndex: 0,
                      totalSwitches: 2,
                      labels: ['Yes', 'No'],
                      onToggle: (index) {
                        switch (index) {
                          case 0:
                            {
                              _allergens = true;
                              break;
                            }
                          case 1:
                            {
                              _allergens = false;
                              break;
                            }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 15),
        child: ElevatedButton(
          child: const Text(
            'Submit',
            style: TextStyle(fontSize: 20),
          ),
          onPressed: () async {
            if (validate()) {
              Food food = await createFood(_user!.getId());

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('New food ${food.getFoodTitle()} created'),
                  content: const Text('View food in view your foods menu'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        clearControllers();
                        Navigator.pop(context);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            } else {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Food form  Error'),
                  content: const Text('Wrong input'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                        clearControllers();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }

  bool validate() {
    return _dayController.text.isNotEmpty &&
        _monthController.text.isNotEmpty &&
        _yearController.text.isNotEmpty &&
        _foodTitleController.text.isNotEmpty &&
        _foodDescController.text.isNotEmpty &&
        _monthController.text.length >= 2 &&
        _dayController.text.length >= 2 &&
        _yearController.text.length >= 4;
  }

// late ObjectId _id;
// late int _userId;
// late String _foodTitle;
// late String _foodDesc;
// late DateTime _expr;
// late bool _allergens;
// late bool _collected;
// late bool _status;

  Future<Food> createFood(id) async {
    //2022-11-18
    var _userId = id;
    var _foodTitle = _foodTitleController.text;
    var _foodDesc = _foodDescController.text;
    var _expr =
        '${_yearController.text}-${_dayController.text}-${_dayController.text}';
    bool allergens = _allergens;
    var collected = false;
    var status = false;
    var food = await Food.newFood(_userId, _foodTitle, _foodDesc,
        DateTime.parse(_expr), allergens, widget.database, collected, status);
    await food.upload();

    return food;
  }

  void clearControllers() {
    _dayController.clear();
    _monthController.clear();
    _yearController.clear();
    _foodTitleController.clear();
    _foodDescController.clear();
  }

  void innitUser() async {
    var temp = await widget.database.getLogged();

    setState(() {
      _user = temp;
    });
  }
}
