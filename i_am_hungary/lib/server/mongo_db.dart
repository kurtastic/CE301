import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_hungary/ObjectClasses/foodClass.dart';
import 'package:i_am_hungary/ObjectClasses/marker_details.dart';
import 'package:i_am_hungary/ObjectClasses/requestClass.dart';
import 'package:i_am_hungary/ObjectClasses/userClass.dart';
import 'package:mongo_dart/mongo_dart.dart';



class Mongo_db {
  static User? loggedIn;
  final String _host =
      "mongodb+srv://admin:admin@imhungary.sdot6.mongodb.net/community?retryWrites=true&w=majority";
  Db? _db;
  //List? <UserClass> users;
  DbCollection? usersCollection;
  DbCollection? foodsCollection;
  DbCollection? requestCollection;

  // DbCollection? markersCollection;

  User getLogged() => loggedIn!;

  start() async {
    initConnection();
  }

  Db getDb()=>_db!;

  Future<Mongo_db> initConnection() async {
    _db = await Db.create(_host);
    await _db?.open();

    usersCollection = await _db?.collection('users');
    foodsCollection = await _db?.collection('foods');
    requestCollection = await _db?.collection('requests');

    return await this;
  }

 

  Future<List> getMarker(int id) async {
    var marker = await usersCollection?.findOne(where.eq('_id', id));
    return [marker!['long'], marker['lat']];
  }

   sendRequests(from, to, ObjectId foodId) async {
    var document = {"_id": foodId, "from": from, "to": to, "status": false};
    await requestCollection?.insert(document);
  }

     markCollected(ObjectId id) async {
      await foodsCollection?.update( where.eq('_id', id), modify.set('collected', true));
      await removeFood(id);
      // await foodsCollection?.remove(where.eq('_id', id));
      // await requestCollection?.remove(where.eq('_id', id));
    }

    removeFood(ObjectId id)async{
            await foodsCollection?.remove(where.eq('_id', id));
            await requestCollection?.remove(where.eq('_id', id));


    }




  Future<List<Marker>> getAllMarkers(BuildContext context) async {
   var list = [];

    await usersCollection?.find().forEach((v) async {

      var marker = await MarkerDetails(v['_id'], v['title'], v['longitude'],
              v['latitude'], v['snippet'], v['type'], this);
      list.add(await marker);

    });
    var markers = <Marker>[];
    for (MarkerDetails item in await list ){
      markers.add(await item.getMarker(context));
    }
   
    return await markers;
  }

  setRequests(bool response, ObjectId id) async {
    await requestCollection?.updateOne(
        where.eq('_id', id), modify.set('status', response));
    await foodsCollection?.updateOne(
        where.eq('_id', id), modify.set('status', response));
  }

  getRequests(int id, BuildContext context) async {
    List<Widget> list = <Widget>[];

    await requestCollection?.find(where.eq('to', id)).forEach((v) async =>
        list.add(Request(v['_id'], v['from'], v['to'], v["status"])
            .getCard(context)));

    return list;
  }


  getRequestsR(int id, BuildContext context) async {
    List<Widget> list = <Widget>[];

    await requestCollection?.find(where.eq('from', id)).forEach((v) async =>
        list.add(Request(v['_id'], v['from'], v['to'], v["status"])
            .getCardR(context)));

    return list;
  }

  Future<List<Widget>> getFoods(id, context) async {
    List<Widget> list = <Widget>[];

    await foodsCollection?.find(where.eq('userId', id)).forEach((v) async =>
        list.add(Food(
                v['_id'],
                v['userId'],
                v['foodTitle'],
                v['foodDesc'],
                DateTime.parse(v['expr']),
                v['allergens'],
                this,
                v['collected'],
                v['status'])
            .getCard(context)));

    return list;
  }

  void close() async {
    await _db?.close();
  }

  void initAllUsers() {}

  Future<List<Widget>> getAllFoods(context) async {
     List<Widget> list = <Widget>[];

    await foodsCollection?.find().forEach((v) async =>
        list.add(Food(
                v['_id'],
                v['userId'],
                v['foodTitle'],
                v['foodDesc'],
                DateTime.parse(v['expr']),
                v['allergens'],
                this,
                v['collected'],
                v['status'])
            .getCard(context)));

    return list;
  }

  void initCollections() async {
    usersCollection = await _db?.collection('users');
    foodsCollection = await _db?.collection('foods');
    //markersCollection = await _db?.collection('markers');
    ;
  }

  Future<bool> verifyUser(String username, String password) async {
    var temp = await usersCollection
        ?.findOne({'username': username, 'pword': password});

    if (await temp != null) {
      loggedIn = await User(
          temp!['_id'],
          temp['title'],
          temp['longitude'],
          temp['latitude'],
          temp['snippet'],
          temp['type'],
          temp['pword'],
          temp['username']);
      return await true;
    } else {
      return await false;
    }
  }

  Future<User> getUserPass(String username) async {
    var temp = await usersCollection?.findOne(where.eq('username', username));
    User user = await User(
        temp!['_id'],
        temp['title'],
        temp['longitude'],
        temp['latitude'],
        temp['snippet'],
        temp['type'],
        temp['pword'],
        temp['username']);
    return user;
  }

  Future<User> getUser(int id) async {
    var temp = await usersCollection?.findOne(where.eq('_id', id));
    User user = await User(
        temp!['_id'],
        temp['title'],
        temp['longitude'],
        temp['latitude'],
        temp['snippet'],
        temp['type'],
        temp['pword'] != null ? temp['pword'] : '',
        temp['username']);
    return user;
  }

  Future<Set> getUserIds() async {
    var listOfId = HashSet<int>();
    await usersCollection?.find().forEach((element) {
      listOfId.add(element['_id']);
    });
    return listOfId;
  }

  Future<bool> checkUserName(String username) async {
    var valid = true;
   await usersCollection?.find().forEach((element) {
      if (element['username'] == username) {
        valid = false;
      }
    });
    return valid;
  }

  void logOff() {
    loggedIn = null;
  }

  getAddress(int id) async {
    var temp = await usersCollection?.findOne(where.eq('_id', id));
    var lat = temp?['latitude'] ;
    var long = temp?['longitude'] ;
    //final coordinates =  Coordinates(
    //      myLocation.latitude, myLocation.longitude);



List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    String Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  
return Address;

  }

}
