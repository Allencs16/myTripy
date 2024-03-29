import 'package:flutter/material.dart';
import 'package:mytripy/components/loading/loading.dart';
import 'package:mytripy/models/token/token.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcome extends StatefulWidget{
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context){

    verifyTokenAndLogin();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('lib/assets/landscape.png'),
            fit: BoxFit.cover,
            alignment: Alignment(-1, 1)
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 42, 0, 8),
                child: Text(
                  'Unforgotten \nExperiences',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    fontSize: 40
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(42, 8, 42, 8),
                child: Text(
                  'Share your best trips around the world \nwith friends and plan the next one',
                  style: TextStyle(
                    color: Color(0xFFffffff),
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 480, 0, 16),
                child: SizedBox(
                  width: 300,
                  height: 45,
                  child: isLoading ? Loading() : ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                    child: const Text('Continue'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor
                    ),
                  ),
                ),
              )
            ],
          )
        )
      ),
    );
  }

  verifyTokenAndLogin() async{
    final SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    String? _emailUsuario = _sharedPreferences.getString("emailUsuario");
    final UserService _userService = getIt<UserService>();

    if(await verifyTokenValid()){
      if (_emailUsuario == null) {
        return;
      }
      Future<User> usuario = getUserInformation(_emailUsuario);
      _userService.setUser(usuario);
      Navigator.pushNamed(context, "/dashboard");
      return;
    } else {
      setState(() {
        isLoading = false;
        return;
      });
    }
  }
}