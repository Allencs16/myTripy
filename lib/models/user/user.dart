import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? bio;
  String? age;
  String? createdAt;
  String? updatedAt;

  User({this.id, this.name, this.email, this.password, this.bio, this.age, this.createdAt, this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'], 
      name: json['name'], 
      email: json['email'], 
      password: json['password'], 
      bio: json['bio'],
      age: json['age'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }
}

Future<User> authenticate(String email, String password) async{
  final RequestService _requestService = getIt<RequestService>();
  final body = {"email": email, "password": password};
  final json = jsonEncode(body);
  final response = await _requestService.httpPostForLogin('token', '/user/authenticate', json);

   if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return User.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}