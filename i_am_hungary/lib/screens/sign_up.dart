import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:i_am_hungary/screens/login_screen.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'package:toggle_switch/toggle_switch.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  Mongo_db database;
  SignUp(this.database);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _pWordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  static const String _title = 'Sign Up';
  bool _type = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          _title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'First and Last Name',
                  hintText: 'seprate names with a space',
                   hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'not case sensitive',
                   hintStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: _pWordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 2, 0),
                    child: TextField(
                      controller: _latitudeController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Latitude',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 10, 10, 0),
                    child: TextField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Longitude',
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(8, 30, 10, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        getCurrentPosition();
                      } catch (e) {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Location not Available'),
                            content: const Text(
                                'There has been an error with getting your location!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text('Get Location'),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Short description',
                  hintText: 'a short line about yourself',
                  hintStyle: TextStyle(fontSize: 14),
                ),
                maxLength: 50,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: ToggleSwitch(
                    minWidth: 90,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: ['Sharer', 'Reqester'],
                    onToggle: (index) {
                      switch (index) {
                        case 0:
                          {
                            _type = true;
                            break;
                          }
                        case 1:
                          {
                            _type = false;
                            break;
                          }
                      }

                    },
                  ),
                ),
              ],
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
              User user = await createUser();

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('New User ${user.getTitle()} created'),
                  content: const Text('Proceed to the Login screen'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        clearControllers();
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login(widget.database)),
                        );
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
                  title: Text('Sign up Error'),
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

  void getCurrentPosition() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position temp) {
      setState(() {
        _latitudeController.text = temp.latitude.toString();
        _longitudeController.text = temp.longitude.toString();
      });
    // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => print(e));

    // return position;
  }

  bool validate() {
    return _nameController.text.isNotEmpty &&
        _pWordController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _latitudeController.text.isNotEmpty &&
        _longitudeController.text.isNotEmpty &&
        _usernameController.text.isNotEmpty && _nameController.text.split(" ").length == 2;
  }

  Future<User> createUser() async {
    var name = _nameController.text.toLowerCase().split(' ');
    name[0] = name[0][0].toUpperCase() + name[0].substring(1);
    name[1] = name[1][0].toUpperCase() + name[1].substring(1);
    var lat = double.parse(_latitudeController.text);
    var long = double.parse(_longitudeController.text);
    var desc = _descriptionController.text;
    var password = _pWordController.text;
    var username = _usernameController.text.toLowerCase();

    var user = User.newUser(
        name[0] + " " + name[1], lat, long, desc, _type, password, username);

    await user.upload();

    return user;
  }

  clearControllers() {
    _usernameController.clear();
    _nameController.clear();
    _pWordController.clear();
    _descriptionController.clear();
    _latitudeController.clear();
    _longitudeController.clear();
    _type = false;
  }
}
