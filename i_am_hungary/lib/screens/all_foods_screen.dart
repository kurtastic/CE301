import 'package:flutter/material.dart';
import 'package:i_am_hungary/server/mongo_db.dart';

// ignore: must_be_immutable
class AllFoods extends StatefulWidget {
  Mongo_db database;
   AllFoods(this.database,{ Key? key }) : super(key: key);

  @override
  State<AllFoods> createState() => _AllFoodsState();
}

class _AllFoodsState extends State<AllFoods> {
var foodList = <Widget>[];


@override
  void initState() {
    super.initState();
    initfoods();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // alignment: Alignment.center,
     // decoration: BoxDecoration(
       backgroundColor: Color.fromARGB(246, 226, 226, 226),
        
     // ),
      body: CustomScrollView(

        slivers: <Widget>[
          
           SliverAppBar(
            pinned: true,
            expandedHeight: 240.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('All Foods',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            ),   
          ),
          //  SliverPersistentHeader(
          //   delegate: Delegate(Color.fromARGB(239, 255, 255, 255), 'Foods Available',25),
          //   pinned: false,
          //   floating: false,
          // ),
          
          SliverFixedExtentList(
            itemExtent: 100.0,
            delegate: SliverChildListDelegate(
              foodList,
            ),
          ),
         
        ],
        
      ),
      
       
    );
    
  }


  void initfoods() async {
    List<Widget> foods = await widget.database.getAllFoods(context);
    setState(() {
      this.foodList = foods;
    });
  }
}