import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/inputText/inputText.dart';
import 'package:mytripy/components/loading/loading.dart';
import 'package:mytripy/components/nativeDatePicker/nativeDatePicker.dart';
import 'package:mytripy/components/section/section.dart';
import 'package:mytripy/models/week/week_model.dart';

class Week extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateWeek();
  }
}

class _StateWeek extends State<Week>{
  DateTime _currentDate = DateTime.now();
  WeekModel? currentWeek;
  int? currentWeekBudget;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
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
                          verifyIfWeekIsActual(snapshot.data as List<WeekModel>);
                          return currentWeek != null ? Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
                                  child: Section(
                                    title: 'Data Início:',
                                    item: Text(DateFormat.yMMMMd('pt-br').format(DateTime.parse(currentWeek!.startDate.toString())))
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Section(
                                    title: 'Data Fim:',
                                    item: Text(DateFormat.yMMMMd('pt-br').format(DateTime.parse(currentWeek!.endDate.toString())))
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Section(
                                    title: 'Total em Budget:',
                                    item: Text("${currentWeek!.totalBudget} reais")
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Section(
                                    title: 'Total em Gastos:',
                                    item: Text("${currentWeek!.totalExpenses} reais")
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0),
                                  child: Section(
                                    title: 'Km Rodados:',
                                    item: Text("${currentWeek!.totalKm} Kilometros"),
                                  ),
                                ),
                              ),
                            ],
                          ) : const Text('Não há uma semana cadastrada.');
                        } else if(snapshot.hasError){                    
                          return Text('');
                        }
                        return Loading();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  verifyIfWeekIsActual(List<WeekModel> listWeek){
    listWeek.forEach((element) { 
      if(_currentDate.isAtSameMomentAs(DateTime.parse(element.startDate.toString())) || _currentDate.isAfter(DateTime.parse(element.startDate.toString())) && _currentDate.isBefore(DateTime.parse(element.endDate.toString())) || _currentDate.isAtSameMomentAs(DateTime.parse(element.endDate.toString()))){
        currentWeek = element;
      }
    });
  }
}