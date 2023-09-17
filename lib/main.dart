import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mytripy/screens/home/home.dart';
import 'package:mytripy/screens/login/login.dart';
import 'package:mytripy/screens/signup/signUp.dart';
import 'package:mytripy/screens/week/week_info.dart';
import 'package:mytripy/screens/welcome/welcome.dart';
import 'package:mytripy/services/serviceLocator.dart';

Future<void> main() async {
  await setupServiceLocator();
  runApp(const MyApp());
  initializeDateFormatting('pt_BR');
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
        primarySwatch: Colors.blue,
      ),
      home: Welcome(),
      routes: {
        '/login': (BuildContext context) => Login(),
        '/dashboard': (BuildContext context) => Home(),
        '/sign-up':(BuildContext context) => SignUp()
      }
    );
  }
}