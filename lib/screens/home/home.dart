import 'package:flutter/material.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Hello world \nthis is myTripy'),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        iconSize: 30,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            label: 'teste',
            activeIcon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tour_outlined), 
            label: 'teste',
            activeIcon: Icon(Icons.tour)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), 
            label: 'teste',
            activeIcon: Icon(Icons.person)
          )
        ]
      ),
    );
  }
}