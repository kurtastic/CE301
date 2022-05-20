//import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:i_am_hungary/screens/marker_info_screen.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

class MarkerDetails {
  double _long;
  double _latitude;
  String _snippet;
  int _id;
  //late Marker _marker;
  Future<BitmapDescriptor> _imagePerson = BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(12, 12)), 'assets/request.png');
  Future<BitmapDescriptor> _imageBussiness = BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(12, 12)), 'assets/give.png');

  String _title;
  bool _type;
  Mongo_db _mongoDB;
  //late Marker _marker;

  MarkerDetails(this._id, this._title, this._long, this._latitude,
      this._snippet, this._type, this._mongoDB);

  // Future <Marker> initMarker()async{}

  // void _setMarkerIcon(type) async {
  //   _image = await type
  //       ? await BitmapDescriptor.fromAssetImage(
  //           const ImageConfiguration(), 'assets/AppIcon29x29.png')
  //       : await BitmapDescriptor.fromAssetImage(
  //           const ImageConfiguration(), 'assets/noodle_icon.png');
  // }

  Future<Marker> getMarker(BuildContext context) async {
    // _setMarkerIcon(_type);

    var _marker = await Marker(
      markerId: MarkerId(_id.toString()),
      position: LatLng(_latitude, _long),
      infoWindow: InfoWindow(
        title: _title,
        snippet: _snippet,
      ),

      icon: await _type ? await _imageBussiness : await _imagePerson,
      onTap: await () {
        if (_type)
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MarkerInfo(_id, _title, _mongoDB)),
          );
      }, //Navigates to  the user info page when tapped
    );

    return _marker;
  }

  @override
  String toString() {
    return "id = $_id , title = $_title";
  }

  //onTap:(){  Navigator.push(context,MaterialPageRoute(builder: (context) => UserInfo.withInfo(_id.toString(),_title,_snippet)),);}, //Navigates to  the user info page when tapped

//   static void getUserInfo(String _id,BuildContext context){

//    Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) =>  UserInfo()),
//   );

//   }
// }

}
