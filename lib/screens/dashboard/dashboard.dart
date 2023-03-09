import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';

class Dashboard extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _StateDashboard();
  }
}

class _StateDashboard extends State<Dashboard>{

  final UserService _userService = getIt<UserService>();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 350,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xffffffff)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Color(0xff000000),
                        borderRadius: BorderRadius.circular(25.0)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 15.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Welcome back',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xffc3c3c3)
                            ),
                          ),
                          FutureBuilder<User>(
                            future: _userService.getUserLogado(),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return Text(
                                  snapshot.data!.name.toString(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                );
                              } else if (snapshot.hasError){
                                print(snapshot.error);
                                return Text('Não foi possivel carregar usuario');
                              }
                              return CupertinoActivityIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffB35340),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      )
    );
  }
}