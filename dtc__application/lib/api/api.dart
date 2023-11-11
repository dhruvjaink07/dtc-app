import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const String baseUrl = 'https://127.0.0.1:5010';

  static Future<bool> loginUser(String username, String password) async {
    final apiUrl = '$baseUrl/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<bool> registerUser(String username, String password) async {
    final apiUrl = '$baseUrl/auth/register';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }
}
