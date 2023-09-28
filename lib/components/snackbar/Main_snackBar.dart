import 'package:flutter/material.dart';

class MainSnackBar {
  static void showSnackBar(BuildContext context, String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).primaryColor,
      )
    );
  }
}