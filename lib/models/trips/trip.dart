import 'dart:convert';

import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Trip {
  int? id;
  String? name;
  String? description;
  bool? isQuiet;
  num? price;
  String? place;
  DateTime? createdAt;
  String? coordinates;

  Trip({this.id, this.name, this.description, this.isQuiet, this.price, this.createdAt, this.place, this.coordinates});

  factory Trip.fromJson(Map<String, dynamic> json){
    return Trip(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      isQuiet: json["isQuiet"],
      coordinates: json["coordinates"],
      place: json["place"],
      createdAt: DateTime.parse(json["createdAt"]),
      price: json["price"]
    );
  }
}

Future<List<Trip>> getTrips() async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  var response = await _requestService.httpGet(token.toString(), "/trip");
  
  var decodedResponde = jsonDecode(response.body);

  List<Trip> finalResponse = List<Trip>.from(decodedResponde.map((trip) => Trip.fromJson(trip))).toList();

  if(response.statusCode == 200){
    return finalResponse;
  }else {
    throw Exception("Error");
  }
}