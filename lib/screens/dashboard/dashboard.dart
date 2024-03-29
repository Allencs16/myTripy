import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/bottomSheet/bottom_sheet.dart';
import 'package:mytripy/components/loading/loading.dart';
import 'package:mytripy/models/trips/trip.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/models/week/week_model.dart';
import 'package:mytripy/screens/trip/trip.dart';
import 'package:mytripy/screens/week/week_info.dart';
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
  DateTime todayDate = DateTime.now();
  DateTime _selectDate = DateTime.now();
  late int? userId;
  Future<List<TripModel>> trip = getTripByUserAndDay(DateTime.now());

  final UserService _userService = getIt<UserService>();

  initializeUser() async {
    User user = await _userService.getUserLogado();
    userId = user.id;
  }

  @override
  Widget build(BuildContext context){
    DateTime futureDate = DateTime(DateTime.now().year + 1);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
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
                            'Bem vindo de volta',
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                      },
                      child: Container(
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
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, top: 12),
              child: CalendarTimeline(
                initialDate: _selectDate, 
                firstDate: DateTime(todayDate.year - 1), 
                lastDate: futureDate, 
                onDateSelected: (date) {
                  setState(() {
                    _selectDate = date;
                    trip = getTripByUserAndDay(date);
                  });
                },
                dayColor: Theme.of(context).primaryColor,
                activeBackgroundDayColor: Theme.of(context).primaryColor,
                leftMargin: 20,
                locale: 'pt_BR',
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: FutureBuilder<List<TripModel>>(
                  future: trip,
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return Column(
                        children: [
                          snapshot.data!.isEmpty ? const Text('Não há viagens hoje') :
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    clipBehavior: Clip.hardEdge,
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () => selectTrip(snapshot.data!.elementAt(index)),
                                      child: SizedBox(
                                        width: 300,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom:8.0),
                                              child: ListTile(
                                                leading: const Icon(Icons.map_outlined),
                                                title: Text(
                                                  "Proxima cidade: ${snapshot.data!.elementAt(index).name}",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                subtitle: Text("Distancia: ${snapshot.data!.elementAt(index).distanceFromSource.toString()} Km"),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if(snapshot.hasError){
                      return const Text("teste");
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

  selectTrip(TripModel trip){
    Navigator.push(context, MaterialPageRoute(builder: (context) => Trip(trip: trip)));
  }
}