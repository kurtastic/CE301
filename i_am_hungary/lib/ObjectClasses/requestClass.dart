import 'package:flutter/material.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Request {
  ObjectId _id;
  bool _status;
  int _from;
  int _to;

  ObjectId get id => _id;
  int get from => _from;
  int get to => _to;
  bool get status => _status;

  set id(ObjectId id) {
    _id = id;
  }

  set from(int from) {
    _from = from;
  }

  set to(int to) {
    _to = to;
  }

  set status(bool status) {
    _status = status;
  }

  Request(this._id, this._from, this._to, this._status);

  Padding getCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListTile(
          title: Text('Request from $_from'),
          //subtitle: Text('$_foodDesc'),
          trailing: Text('Status $_status'),

          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Request'),
                content: Text('Request from user $from'),
                actions: <Widget>[
            
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Accept');
                      requestReponse(true);
                      
                     // Navigator.popUntil(context);
                      Navigator.pop(context);
                    
                    },
                    child: const Text('Accept'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Reject'),
                    child: const Text('Reject'),
                  ),
                ],
              ),
            );
          },
          enableFeedback: true,
        ),
      ),
    );
  }

  Padding getCardR(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListTile(
          title: Text('Request to $_to'),
          //subtitle: status? showLocation(context, to):"",
          trailing: Text('Status $_status'),

          onTap: () {
           // showLocation(context, to);

            showDialog<String>(
                barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Request Status'),
                content: Text('Request to user $from'),
                actions: dialogueOptions(context),
              ),
            );
          },
          enableFeedback: true,
        ),
      ),
    );
  }

  dialogueOptions(context) {
    if (status == true) {
      return <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Collected?');
            markCollected();
            Navigator.pop(context);
          },
          child: const Text('Collected?'),
        ),
         TextButton(
          onPressed: () {
            showLocation(context, to);
            
            //Navigator.pop(context, 'Show Location');

          },
          child: const Text('Show Location?'),
        ),
          TextButton(
          onPressed: () {
            Navigator.pop(context, 'Dismiss?');
          },
          child: const Text('Dismiss?'),
        ),
      ];
    } else {
      return <Widget>[
        Text(
          "This request is yet to be accepted",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Dismiss?');
          },
          child: const Text('Dismiss?'),
        ),
      ];
    }
  }

  showLocation(context, int id) async {
    var mongo_db = await Mongo_db().initConnection();
    var address = await mongo_db.getAddress(to);

     showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('User Location'),
                  content: Text('$address'),
                 // actions: dialogueOptions(context),
                ),
              );

    return address;
  }

  void requestReponse(bool response) async {
    var mongo_db = await Mongo_db().initConnection();
    await mongo_db.setRequests(response, id);
  }

  void markCollected() async {
    var mongo_db = await Mongo_db().initConnection();
    await mongo_db.markCollected(id);
    
  }
}
