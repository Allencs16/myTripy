import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/models/vehicle/vehicle_model.dart';
import 'package:mytripy/models/week/week_model.dart';
import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:mytripy/services/user/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripModel {
  int? id;
  String? name;
  String? description;
  String? state;
  double? distanceFromSource;
  String? place;
  String? startDay;
  String? endDay;
  WeekModel? weekModel;
  String? stays;
  Vehicle? vehicle;

  TripModel({this.id, this.name, this.description, this.state, this.distanceFromSource, this.place, this.startDay, this.endDay, this.stays, this.vehicle, this.weekModel});

  factory TripModel.fromJson(Map<String, dynamic> json){
    return TripModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      distanceFromSource: json["distanceFromSource"],
      startDay: json["startDay"],
      endDay: json["endDay"],
      place: json["place"],
      state: json["state"],
      stays: json["stays"],
      vehicle: Vehicle.fromJson(json["vehicle"]),
      weekModel: WeekModel.fromJson(json["week"])
    );
  }
}

Future<List<TripModel>> getTrips() async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  var response = await _requestService.httpGet(token.toString(), "/trip");
  
  var decodedResponde = jsonDecode(response.body);

  List<TripModel> finalResponse = List<TripModel>.from(decodedResponde.map((trip) => TripModel.fromJson(trip))).toList();

  if(response.statusCode == 200){
    return finalResponse;
  }else {
    throw Exception("Error");
  }
}

Future<List<TripModel>> getTripByUserAndDay(DateTime date) async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  final UserService _userService = getIt<UserService>();
  var user = await _userService.getUserLogado();
  var userId = user.id;

  String formattedDate = DateFormat('yyyy-MM-dd').format(date);

  var response = await _requestService.httpGet(token.toString(), '/trip/user/$userId/$formattedDate');

  var decodedResponde = jsonDecode(response.body) as List;

  List<TripModel> trips = decodedResponde.map((trip) => TripModel.fromJson(trip)).toList();

  if(response.statusCode == 200){
    return trips;
  } else {
    throw Exception("Error Getting Trips");
  }
}