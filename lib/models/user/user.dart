import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mytripy/models/token/token.dart';
import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? password;
  String? bio;
  String? createdAt;

  User({this.id, this.name, this.username, this.email, this.password, this.bio, this.createdAt,});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'], 
      name: json['name'],
      username: json["username"],
      email: json['email'], 
      password: json['password'], 
      bio: json['bio'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['bio'] = bio;
    data['createdAt'] = createdAt;
    return data;
  }
}

Future<Token> authenticate(String email, String password) async{
  final RequestService _requestService = getIt<RequestService>();
  final body = {"username": email, "password": password};
  final json = jsonEncode(body);
  final response = await _requestService.httpPostForLogin('token', '/authenticate', json);

   if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Token.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<User> getUserInformation(String email) async {
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");
  final response = await _requestService.httpGet(token.toString(), "/user/${email}");

  if(response.statusCode == 200){
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Something went Wrong ${response.statusCode}");
  }
}

Future<bool> createUser(User user) async{
  String userJson = '{"name": "${user.name}", "username": "${user.username}", "email": "${user.email}", "password": "${user.password}"}';
  final RequestService _requestService = getIt<RequestService>();
  final response = await _requestService.httpPost('', '/public/user/create', userJson);

  if(response.statusCode == 200){
    return true;
  } else {
    return false;
  }
}