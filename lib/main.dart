import 'package:flutter/material.dart';
import 'package:mytripy/screens/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myTripy',
      theme: ThemeData(
        primaryColor: const Color(0xFF1FA555),
        primarySwatch: Colors.blue
      ),
      home: Home(),
    );
  }
}