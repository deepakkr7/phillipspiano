import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  static Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https:baseurl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final token = json.decode(response.body)['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return true;
      }
    } catch (e) {
      print('Login error: ${e.toString()}');
    }
    return false;
  }
}