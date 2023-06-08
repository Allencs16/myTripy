import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/models/week/week_model.dart';

class WeekInfo extends StatefulWidget{
  WeekModel week;

  WeekInfo({required this.week});

  @override
  State<StatefulWidget> createState() {
    return _StateWeekInfo();
  }
}

class _StateWeekInfo extends State<WeekInfo>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semana: ${DateFormat.yMMMMd('pt-BR').format(DateTime.parse(widget.week.startDate.toString()))}'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.week.budget.toString())
            ],
          ),
        )
      ),
    );
  }
}