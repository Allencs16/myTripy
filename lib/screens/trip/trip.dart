import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytripy/components/section/section.dart';
import 'package:mytripy/models/trips/trip.dart';

class Trip extends StatefulWidget{
  TripModel trip;

  Trip({required this.trip});

  @override
  State<StatefulWidget> createState() {
    return _TripState();
  }
}

class _TripState extends State<Trip>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip.name.toString()),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Section(
                          title: 'Distancia:', 
                          item: Text(
                            '${widget.trip.distanceFromSource.toString()} Km',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Data Início:', 
                          item: Text(
                            DateFormat.yMMMMd('pt-BR').format(DateTime.parse(widget.trip.startDay.toString())),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Data Fim:', 
                          item: Text(
                            DateFormat.yMMMMd('pt-BR').format(DateTime.parse(widget.trip.endDay.toString())),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Descrição:', 
                          item: Text(
                            widget.trip.description.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                      SizedBox(
                        child: Section(
                          title: 'Budget Disponível:', 
                          item: Text(
                            '${widget.trip.weekModel!.totalBudget.toString()} Reais',
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey
                            )
                          )
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}