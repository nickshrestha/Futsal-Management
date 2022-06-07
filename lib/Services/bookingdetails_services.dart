// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:http/http.dart';
import 'package:myhomepage/Services/auth_service.dart';

class BookingService {
  final String baseUrl = "http://localhost:3000/";

  String error = '';

  Future getBookings() async {
    final token = await AuthService().getToken();
    Response res = await get(Uri.parse(baseUrl + 'bookings'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode < 200 || res.body == null) {
      return [];
    } else if (res.statusCode >= 400) {
      final errorObj = jsonDecode(res.body)['message'];

      if (errorObj.runtimeType == List) {
        error = errorObj[0];
      } else {
        error = jsonDecode(res.body)['message'];
      }
      return [];
    }
    return res.body;
  }
}
