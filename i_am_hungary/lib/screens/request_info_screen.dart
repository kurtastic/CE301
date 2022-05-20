import 'package:flutter/material.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

// ignore: must_be_immutable
class RequestInfo extends StatefulWidget {
  Mongo_db database;

  RequestInfo(this.database, {Key? key}) : super(key: key);

  @override
  State<RequestInfo> createState() => _RequestInfoState();
}

class _RequestInfoState extends State<RequestInfo> {
  var _requests = <Widget>[];

  @override
  void initState() {
    super.initState();
    initRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Page",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(children: _requests),
      ),
    );
  }

  void initRequest() async {
    var temp;
    var user = await widget.database.getLogged();
    if (await user.getType()) {
      temp = await widget.database.getRequests(user.getId()!, context);
    } else {
      temp = await widget.database.getRequestsR(user.getId()!, context);
    }

    if (await temp != null) {
      setState(() {
        _requests = temp;
      });
    }
  }
}
