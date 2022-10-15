import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateDashboard();
  }
}

class _StateDashboard extends State<Dashboard>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Text('Dashboard'),
      ),
    );
  }
}