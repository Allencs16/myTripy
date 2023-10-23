import 'dart:convert';

import 'package:mytripy/models/user/user.dart';
import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeekModel {
  int? id;
  double? totalPrice;
  double? totalKm;
  double? totalBudget;
  double? totalExpenses;
  DateTime? startDate;
  DateTime? endDate;
  User? user;
  bool? current;

  WeekModel({
    this.id,
    this.totalPrice,
    this.totalKm,
    this.totalBudget,
    this.totalExpenses,
    this.startDate,
    this.endDate,
    this.user,
    this.current
  });

  factory WeekModel.fromJson(Map<String, dynamic> json){
    return WeekModel(
      id: json["id"],
      totalPrice: json["totalPrice"],
      totalKm: json["totalKm"],
      totalBudget: json["totalBudget"],
      totalExpenses: json["totalExpenses"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      user: User.fromJson(json["user"]),
      current: json["current"]
    );
  }
}

Future<List<WeekModel>> getWeekByUser() async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  var response = await _requestService.httpGet(token.toString(), "/week");
  
  var decodedResponde = jsonDecode(response.body);

  List<WeekModel> finalResponse = List<WeekModel>.from(decodedResponde.map((week) => WeekModel.fromJson(week)));

  if(response.statusCode == 200){
    return finalResponse;
  }else {
    throw Exception("Error");
  }
}