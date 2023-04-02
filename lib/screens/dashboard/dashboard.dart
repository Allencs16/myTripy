import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/loading/loading.dart';
import 'package:mytripy/models/trips/trip.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';
import 'package:intl/date_symbol_data_local.dart';

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
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                );
                              } else if (snapshot.hasError){
                                return Text('Não foi possivel carregar usuario');
                              }
                              return Loading();
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xffB35340),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: FutureBuilder<List<Trip>>(
                  future: getTrips(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Card(
                            clipBehavior: Clip.hardEdge,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                debugPrint('Card tapped.');
                              },
                              child: SizedBox(
                                width: 300,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        "https://images.squarespace-cdn.com/content/v1/5b0eb59df793928fa7f488ff/1536780543743-TZT0SJMRKV5LUOOY8FS0/Industryyyy.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:8.0),
                                      child: ListTile(
                                        title: Text(
                                          snapshot.data!.elementAt(index).name.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        subtitle: Text(snapshot.data!.elementAt(index).description.toString()),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if(snapshot.hasError){
                      print(snapshot.error);
                      return Text("error");
                    }
                    return Loading();
                  },
                ),
              ),
            )
          ],
        )
      )
    );
  }
}