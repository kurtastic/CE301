import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_am_hungary/screens/all_foods_screen.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

// ignore: must_be_immutable
class Gmap extends StatefulWidget {
  Mongo_db database;
  Gmap(this.database, {Key? key}) : super(key: key);

  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  Set<Marker> _markers = HashSet<Marker>();


  @override
  void initState() {
    super.initState();
    //initMongoDb();
    initMarker();
  }



  void initMarker() async {
    // widget.database = await Mongo_db().initConnection();

    List<Marker> markers = await widget.database.getAllMarkers(context);
    setState(() {
      for (var marker in markers) {
        _markers.add(marker );
      }
    });
  }

  

  void _onMapCreated(GoogleMapController controller) {
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _markers = _markers;
    });

    final ButtonStyle style =
        TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Map',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        )),
        actions: <Widget>[
          TextButton(
            style: style,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllFoods(widget.database)),
              );
            },
            child: const Text('All foods',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(51.88921, 0.90421),
              zoom: 12,
            ),
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Text("I am Hungry"),
          )
        ],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Increment',
        child: Icon(Icons.map),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => super.widget));
          
        },
      ),
    );
  }

  void userInfoPopUp(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bctx) {
          return Container(
            child: Text("Hello"),
          );
        });
  }
}
