import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/inputText/inputText.dart';
import 'package:mytripy/components/loading/loading.dart';
import 'package:mytripy/components/nativeDatePicker/nativeDatePicker.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Criar Semana"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  const SizedBox(
                    child: Text(
                      "Selecione as datas",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Stepper(
                    currentStep: indexStepper,
                    onStepCancel: () {
                      if (indexStepper > 0) {
                        setState(() {
                          indexStepper -= 1;
                        });
                      }
                    },
                    onStepContinue: () {
                      if (indexStepper <= 0) {
                        setState(() {
                          indexStepper += 1;
                        });
                      }
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        indexStepper = index;
                      });
                    },

                    steps: [
                      Step(
                        isActive: indexStepper == 0 ? true : false,
                        title: const Text("Selecione a data inicio"), 
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CalendarCarousel(
                            onDayPressed: (data, event) {
                              setState(() {
                                _currentDate = data;
                              });
                            },
                            headerText: '${DateFormat.yMMMMd('pt_BR').format(_currentDate)}',
                            weekFormat: true,
                            height: 200.0,
                            selectedDateTime: _currentDate,
                            minSelectedDate: _currentDate.subtract(Duration(days: 360)),
                            maxSelectedDate: _currentDate.add(Duration(days: 360)),
                            markedDatesMap: _markedDateMap,
                            iconColor: Colors.black,
                          ),
                        )
                      ),
                      Step(
                        isActive: indexStepper == 1 ? true : false,
                        title: Text('Selecione a data final'), 
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: CalendarCarousel(
                            onDayPressed: (data, event) {
                              setState(() {
                                _currentDate2 = data;
                              });
                            },
                            headerText: DateFormat.yMMMMd('pt_BR').format(_currentDate2),
                            weekFormat: true,
                            height: 200.0,
                            selectedDateTime: _currentDate2,
                            minSelectedDate: _currentDate.subtract(Duration(days: 360)),
                            maxSelectedDate: _currentDate.add(Duration(days: 360)),
                            markedDatesMap: _markedDateMap,
                            iconColor: Colors.black,
                          ),
                        )
                      ),
                      Step(
                        title: Text('Selecione o Usuário'),
                        content: SizedBox(
                          child: FutureBuilder(
                            builder: (context, snapshot) {
                              return Loading();
                            },
                          ),
                        )
                      )
                    ]
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}