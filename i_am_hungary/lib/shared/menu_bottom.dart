
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
class MenuBottom extends StatelessWidget {
  const MenuBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index){
        switch (index){
          case 0:
          Navigator.pushNamed(context,'/');
          break;
          case 1:
          Navigator.pushNamed(context,'/gmap');
          break;
          case 2:
          Navigator.pushNamed(context, '/user');
          break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Map'
        ),
     
         BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_outlined),
          label: 'Account'
        ),
      ],
    );
  }
}