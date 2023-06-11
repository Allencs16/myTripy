import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytripy/components/inputText/inputText.dart';
import 'package:mytripy/components/nativeDatePicker/nativeDatePicker.dart';

class Week extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateWeek();
  }
}

class _StateWeek extends State<Week>{
  
  String _selectedDate = 'Select a date';
  DateTime selectedDate = DateTime.now();
  

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await _showDatePicker(context);

    if (picked != null) {
      setState(() {
        _selectedDate = picked.toString();
      });
    }
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    DateTime maxDate = DateTime.now();
    if (Platform.isAndroid) {
      return await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 1, 1),
        lastDate: DateTime(2030, 12, 31),
      );
    } else if (Platform.isIOS) {
      return await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2020, 1, 1),
              maximumDate: DateTime(maxDate.year + 2),
              onDateTimeChanged: (DateTime dateTime) {
                selectedDate = dateTime;
                setState(() {
                  
                });
              },
            ),
          );
        },
      );
    }
  }
  
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
                  GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Text(
                      '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Selecione a data'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    )
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