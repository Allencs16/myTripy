import 'package:flutter/material.dart';

class Button extends StatelessWidget{

  VoidCallback onPressed;
  String title;

  Button({required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child:  Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: StadiumBorder()
      ),
    );
  }
}