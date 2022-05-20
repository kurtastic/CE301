import 'dart:math';

import 'package:i_am_hungary/server/mongo_db.dart';

class User {
late int _id;
late double _latitude;
late double _longitude;
late String _title;
late String _snippet;
late bool _type;
late String _pword;
late String _username;
  User(int id, String title, double latitude, double longitude, String snippet, bool type, String pword, String username){
       // this._id = checkId();
       this._id = id;
        this._title = title;
        this._latitude = latitude;
        this._longitude = longitude;
        this._snippet = snippet;
        this._type = type;
        this._pword = pword;
        this._username = username;
      }
      User.empty(){
this._id = 0;
        this._title = "title";
        this._latitude = 123;
        this._longitude = 123;
        this._snippet = "snippet";
        this._type = false;
        this._pword = "pword";
        this._username = "username";
      }

      User.newUser( String title, double latitude, double longitude, String snippet, bool type, String pword,String username){
        this._id = 0;
        this._title = title;
        this._latitude = latitude;
        this._longitude = longitude;
        this._snippet = snippet;
        this._type = type;
        this._pword = pword;
        this._username = username;

      }



  int? getId() => _id;
  double getLatitude() => _latitude;
  double getLongitude() => _longitude;
  String getTitle() => _title;
  String getSnippet() => _snippet;
  bool getType() => _type;
  String getPword() => _pword;
  String getUsername() => _username;

  setId()async{
    _id = await checkId();
  }
// late int _id;
// late double _latitude;
// late double _longitude;
// late String _title;
// late String _snippet;
// late bool _type;
// late String _pword;
  upload() async {
    var userToSave;
    await setId();
    var mongo_db = await Mongo_db().initConnection();
     var coll = await mongo_db.usersCollection;
     userToSave= {"_id": _id,"latitude":_latitude, "longitude": _longitude,"title":_title, "snippet": _snippet, "type": _type, "pword": _pword,"username": _username};
     await coll?.insert(userToSave);

  }

   Future<int> checkId() async {
    var mongo_db = await Mongo_db().initConnection();
    var coll = await mongo_db.getUserIds();
    
    var rand = Random();
    bool valid = true;
    var temp = rand.nextInt(100);
    while (valid) {
      if (!coll.contains(temp)&& temp != 0) {
        valid = false;
      }else{
        temp = rand.nextInt(100);
        }
    }
    return temp;
  }
 


  
}

