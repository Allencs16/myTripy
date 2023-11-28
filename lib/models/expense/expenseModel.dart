import 'dart:convert';

import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseModel {
  String? type;
  int? value;
  int? weekId;
  String? expenseDate;

  ExpenseModel({this.type, this.value, this.weekId, this.expenseDate});

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    value = json['value'];
    weekId = json['weekId'];
    expenseDate = json['expenseDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['value'] = this.value;
    data['weekId'] = this.weekId;
    data['expenseDate'] = this.expenseDate;
    return data;
  }
}

Future<ExpenseModel> createAndSaveExpense(ExpenseModel expense) async{
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  DateTime date = DateTime.now();
  String formattedDate = date.toIso8601String();

  String expenseModel = '{"type": ${int.parse(expense.type.toString())}, "value": ${expense.value}, "weekId": ${expense.weekId}, "expenseDate": "${formattedDate}"}';

  var response = await _requestService.httpPost(token.toString(), "/expenses", expenseModel);

  if(response.statusCode == 200){
    return ExpenseModel.fromJson(jsonDecode(response.body));
  }else {
    throw Exception();
  }
}