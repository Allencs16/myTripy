import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/models/week/week_model.dart';
import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Trip {
  int? id;
  String? name;
  String? description;
  String? state;
  num? distanceFromSource;
  double? price;
  String? place;
  double? food;
  DateTime? startDay;
  DateTime? endDay;
  WeekModel? weekModel;
  String? stays;
  String? vehicle;

  Trip({this.id, this.name, this.description, this.state, this.price, this.distanceFromSource, this.place, this.startDay, this.endDay, this.food, this.stays, this.vehicle, this.weekModel});

  factory Trip.fromJson(Map<String, dynamic> json){
    return Trip(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      distanceFromSource: json["distanceFromSource"],
      startDay: json["startDay"],
      endDay: json["endDay"],
      food: json["food"],
      place: json["place"],
      price: json["price"],
      state: json["state"],
      stays: json["stays"],
      vehicle: json["vehicle"],
      weekModel: WeekModel.fromJson(json["week"])
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

Future<Trip> getTripByUserAndDay(DateTime date) async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  final UserService _userService = getIt<UserService>();
  var user = await _userService.getUserLogado();
  var userId = user.id;

  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  var response = await _requestService.httpGet(token.toString(), '/trip/user/$userId/$formattedDate');

  var decodedResponde = jsonDecode(response.body);

  print(decodedResponde);
  Trip trip = Trip.fromJson(decodedResponde);

  if(response.statusCode == 200){
    return trip;
  } else {
    throw Exception("Error Getting Trips");
  }
}