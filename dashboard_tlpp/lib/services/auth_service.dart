import 'dart:convert';
import 'dart:io';
import 'package:dashboard_tlpp/services/web_client.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  http.Client client = WebClient().client;
  static const String resource = "api/oauth2/v1/token";

  Future<String> login(String user, String password) async {
    final bytes = utf8.encode('$user:$password');
    final base64Str = base64.encode(bytes);
    http.Response response = await client.post(
      Uri.parse("${WebClient.url}$resource?grant_type=password&username=$user&password=$password"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Basic $base64Str',
        },
    );

    if (response.statusCode != 201) {

      if (response.statusCode == 401) {
        throw UserNotFoundException();
      }

      throw HttpException(response.body.toString());
    }

    return saveInfosFromResponse(response.body, password);
  }

  Future<String> saveInfosFromResponse(String body, String password) async {
    String token = '';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> jsonReturn = json.decode(body);

    token = jsonReturn["access_token"];
    prefs.setString('token', token);

    return token;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('first_name');
    if (token != null) {
      return token;
    }
    return '';
  }

  verifyException(String error) {
    switch (error) {
      case 'jwt expired':
        throw HttpException(error);
    }

    throw HttpException(error);
  }
}

class UserNotFoundException implements Exception {}
