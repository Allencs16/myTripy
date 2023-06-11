import 'dart:convert';

import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Vehicle {
  int? id;
  String? name;
  double? price;
  String? brand;
  double? kmAveragePerLiter;
  double? maxDistance;

  Vehicle({this.id, this.name, this.price, this.brand, this.kmAveragePerLiter, this.maxDistance});

  factory Vehicle.fromJson(Map<String, dynamic> json){
    return Vehicle(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      brand: json["brand"],
      kmAveragePerLiter: json["kmAveragePerLiter"],
      maxDistance: json["maxDistance"]
    );
  }
}

Future<List<Vehicle>> getVehicles() async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  var response = await _requestService.httpGet(token.toString(), "/vehicles");

  var decodedResponde = jsonDecode(response.body);

  List<Vehicle> vehicles = List<Vehicle>.from(decodedResponde.map((vehicle) => Vehicle.fromJson(vehicle))).toList();

  if(response.statusCode == 200){
    return vehicles;
  } else{
    throw Exception(response.statusCode);
  }
}