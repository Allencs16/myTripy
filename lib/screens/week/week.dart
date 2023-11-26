import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/inputText/inputText.dart';
import 'package:mytripy/components/loading/loading.dart';
import 'package:mytripy/components/nativeDatePicker/nativeDatePicker.dart';
import 'package:mytripy/models/week/week_model.dart';

class Week extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateWeek();
  }
}

class _StateWeek extends State<Week>{
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  int indexStepper = 0;

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 2, 10): [
        new Event(
          date: new DateTime(2019, 2, 10),
          title: 'Event 1',
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
      ],
    },
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15.0),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(
                    "Semana Atual:",
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: FutureBuilder<List<WeekModel>>(
                    future: getWeekByUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.length.toString());
                      } else if(snapshot.hasError){
                        print(snapshot.error);
                        return Text('data');
                      }
                      return Loading();
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}