import 'dart:convert';

import 'package:http/http.dart' as http;

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

  Future<User> fetchAlbum() async {
    final response = await http.get(Uri.parse('http://localhost:3000/user/3'));

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
}