// ignore_for_file: await_only_futures

import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "http://localhost:3000/auth/";

  String error = '';

  Future<bool> signUp(
      String firstname, String lastname, String email, String password) async {
    Map<String, String> body = {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password
    };

    Response res = await post(Uri.parse(baseUrl + 'signup'), body: body);
    // ignore: unnecessary_null_comparison
    if (res.statusCode < 200 || res.body == null) {
      return false;
    } else if (res.statusCode >= 400) {
      final errorObj = jsonDecode(res.body)['message'];

      if (errorObj.runtimeType == List) {
        error = errorObj[0];
      } else {
        error = jsonDecode(res.body)['message'];
      }
      return false;
    }
    return true;
  }

  Future<bool> signIn(String email, String password) async {
    Map<String, String> body = {'email': email, 'password': password};

    Response res = await post(Uri.parse(baseUrl + 'signin'), body: body);

    // ignore: unnecessary_null_comparison
    if (res.statusCode < 200 || res.body == null) {
      return false;
    } else if (res.statusCode >= 400) {
      final errorObj = jsonDecode(res.body)['message'];

      if (errorObj.runtimeType == List) {
        error = errorObj[0];
      } else {
        error = jsonDecode(res.body)['message'];
      }
      return false;
    }
    final token = jsonDecode(res.body)['access_token'];
    await _saveToken(token);
    return true;
  }

  _saveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_access_token', token);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final token = await prefs.getString('jwt_access_token');
    if (token == null) return '';
    return token;
  }
}
