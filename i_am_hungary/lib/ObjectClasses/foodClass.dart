import 'package:flutter/material.dart';
import 'package:i_am_hungary/screens/food_info_screen.dart';
import 'package:i_am_hungary/server/mongo_db.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Food {
  late ObjectId _id;
  late int _userId;
  late String _foodTitle;
  late String _foodDesc;
  late DateTime _expr;
  late bool _allergens;
  late bool _collected;
  late bool _status;
 
  Mongo_db _database;

  Food(this._id, this._userId, this._foodTitle, this._foodDesc, this._expr,
      this._allergens,this._database,this._collected,this._status);

  Food.newFood(this._userId, this._foodTitle, this._foodDesc, this._expr,
      this._allergens,this._database,this._collected,this._status){
        _id = ObjectId();

      }
  
  Mongo_db getDatabase() => _database;
  ObjectId getId() => _id;
  int getUserId() => _userId;
  String getFoodTitle() => _foodTitle;
  String getFoodDesc() => _foodDesc;
  DateTime getExpr() => _expr;
  bool getAllergens() => _allergens;
  bool getCollected()=> _collected;
  bool getStatus() => _status;

  int getTimeLeft() {
    return _expr.compareTo(DateTime.now());
  }

  

  @override
  String toString() {
    return "[$_id,$_userId,$_foodTitle,$_foodDesc,$_expr,$_allergens]";
  }

  Container getCard(BuildContext context)  {
     
    return  
          Container(
            height: 500,
            child: Card(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 20,
              child: ListTile(
                title: Text('$_foodTitle',style: TextStyle(fontWeight: FontWeight.w500),),
                subtitle: Text('$_foodDesc'),
                trailing: Icon(Icons.more_vert),
                onTap: () {
                   Navigator.push(
                          context,
                   MaterialPageRoute (
                          builder: (context) =>  FoodInfo(this, _database.getLogged()),
                        ));
                },
                enableFeedback: true,
                
                
              ),
            
        
      ),
         margin: EdgeInsets.all(10), );
    
  }

  setCollected(int id) {
var coll = _database.foodsCollection;

      coll!.updateOne(where.eq('userId', id), modify.set('collected', true));

    return !_collected;
  }
  setStatus() {

    var coll = _database.foodsCollection;

      coll!.updateOne(where.eq('_id', _id), modify.set('status', true));
    return !_status;
  }

// late ObjectId _id;
//   late int _userId;
//   late String _foodTitle;
//   late String _foodDesc;
//   late DateTime _expr;
//   late bool _allergens;
//   late bool _collected;
//   late bool _status;


  upload() async {
    var userToSave;
    var mongo_db = await Mongo_db().initConnection();
     var coll = await mongo_db.foodsCollection;
     userToSave= {"userId":_userId, "foodTitle": _foodTitle,"foodDesc":_foodDesc, "expr": '${_expr.year}-${_expr.month}-${_expr.day}', "allergens": _allergens, "collected": _collected,"status": _status};
     await coll?.insert(userToSave);

  }




}
