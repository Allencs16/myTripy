import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class Loading extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateLoading();
  }
}

class _StateLoading extends State<Loading>{
  @override
  Widget build(BuildContext context) {
    
    if(Platform.isIOS){
      return CupertinoActivityIndicator();
    } else {
      return CircularProgressIndicator();
    }
  }
}