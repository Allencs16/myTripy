import 'package:flutter/material.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';

class Home extends StatefulWidget{
  late User usuario;
  final UserService _userService = getIt<UserService>();
  @override
  State<Home> createState() {
    usuario = _userService.getUser();
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('${widget.usuario.name}'),
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