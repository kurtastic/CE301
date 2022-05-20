import 'package:flutter/material.dart';
import 'package:i_am_hungary/screens/sign_up.dart';
import 'package:i_am_hungary/screens/welcome_screen.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Mongo_db database;
  Login(this.database);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _pWordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  static const String _title = 'Log in';

  @override
  void initState() {
    super.initState();
    //loadDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key('loginAppBar'),
        title: const Text(
          _title,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                key: Key('usernameTextfield'),
                controller: _userNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'Enter username here',
                  hintStyle: TextStyle(fontSize: 14),
                  
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                key: Key('passwordTextfield'),
                  obscureText: true,
                  controller: _pWordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password here',
                    hintStyle: TextStyle(fontSize: 14),

                  ),
                  onSubmitted: (value) {
                    verify(_userNameController.text.replaceAll(' ', ''), value);
                  }),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  key: Key('loginButton'),
                  child: const Text('Login'),
                  onPressed: () {
                    verify(_userNameController.text.replaceAll(' ', '').toLowerCase(),
                        _pWordController.text);
                  },
                )),
            Row(
              children: <Widget>[
                const Text('New User?'),
                TextButton(
                  key: Key('signUpButton'),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignUp(widget.database)),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }



  bool validate() {
    return _userNameController.text.isNotEmpty &&
        _pWordController.text.isNotEmpty;
  }

  Future<bool?> verify(username, password) async {
    // var mongo_db = await Mongo_db().initConnection();
    var result = await widget.database.verifyUser(username, password);
    //
    //
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Login Error'),
          content: const Text('Please try again'),
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
    return result;
  }

  void clearControllers() {
    _pWordController.clear();
    _userNameController.clear();
  }
}
