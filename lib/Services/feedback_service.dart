import 'dart:convert';

import 'package:http/http.dart';
import 'package:myhomepage/Services/auth_service.dart';

class FeedbackService {
  String baseUrl = "http://localhost:3000/feedbacks/";
  String error = '';

  Future<bool> create(String username, String email, String feedback) async {
    final body = jsonEncode(
        {'username': username, 'email': email, 'feedback': feedback});
    String token = await AuthService().getToken();

    Response res =
        await post(Uri.parse(baseUrl + 'create'), body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (res.statusCode < 200) {
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
}
