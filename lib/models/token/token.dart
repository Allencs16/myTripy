import 'package:mytripy/services/requestService.dart/request-service.dart';
import 'package:mytripy/services/serviceLocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Token{
  String? token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json){
    return Token(token: json["token"]);
  }
}

Future<bool> verifyTokenValid() async{
  final RequestService _requestService = getIt<RequestService>();
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString("token");

  var response = await _requestService.httpPost(token.toString(), "/refresh", '');

  if(response.statusCode == 200){
    return true;
  }else {
    return false;
  }
}