import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NativeDatePicker extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateNativeDatePicker();
  }
}

class _StateNativeDatePicker extends State<NativeDatePicker>{
  String _selectedDate = 'Select a date';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await _showDatePicker(context);

    if (picked != null) {
      setState(() {
        _selectedDate = picked.toString();
      });
    }
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
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
            height: 300,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2020, 1, 1),
              maximumDate: DateTime(2030, 12, 31),
              onDateTimeChanged: (DateTime dateTime) {},
            ),
          );
        },
      );
    } else {
      // Unsupported platform, handle accordingly
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _selectedDate,
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
          ],
        ),
      ),
    );
  }
}