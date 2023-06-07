import 'package:flutter/material.dart';

class Week extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateWeek();
  }
}

class _StateWeek extends State<Week>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text("Teste")
            ],
          ),
        )
      ),
    );
  }
}