import 'package:flutter/material.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/screens/dashboard/dashboard.dart';
import 'package:mytripy/screens/profile/profile.dart';
import 'package:mytripy/screens/week/week.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';

class Home extends StatefulWidget{
  @override
  State<Home> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;
  final List<Widget> _widgetList = <Widget>[
    Dashboard(),
    Week(),
    Profile()
  ];

  void changeIndex(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
        currentIndex: _selectedIndex,
        onTap: changeIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            label: 'Dashboard',
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tour_outlined), 
            label: 'Week',
            activeIcon: Icon(Icons.tour)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), 
            label: 'Profile',
            activeIcon: Icon(Icons.person)
          )
        ]
      ),
    );
  }
}