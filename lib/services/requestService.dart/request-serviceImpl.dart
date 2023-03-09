import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mytripy/services/requestService.dart/request-service.dart';

class RequestServiceImpl extends RequestService {
  final String baseUrl = 'http://localhost:8889';
  final String prodBaseUrl = '';

  @override
  Future httpGet(String token, String url) {
    final response = http.get(Uri.parse(baseUrl + url), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ' + token,
    });
    return response;
  }

  @override
  Future httpPost(String token, String url, String body) {
    final response = http.post(
      Uri.parse(baseUrl + url),
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Bearer ' + token,
      },
    );

    return response;
  }

  @override
  Future httpPostForLogin(String token, String url, String body) {
    final response = http.post(
      Uri.parse(baseUrl + url),
      body: body,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Future httpUpdate(String token, String url, String body) {
    final response = http.put(Uri.parse(baseUrl + url), body: body);
    return response;
  }

  @override
  Future httpDelete(String token, String url, String body) {
    final response = http.delete(Uri.parse(baseUrl + url), body: body);
    return response;
  }
}
