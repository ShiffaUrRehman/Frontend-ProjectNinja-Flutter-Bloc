import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/models/user_model.dart';

class LoginRepo {
  static late User user;

  static Future<dynamic> userLogin(String username, String password) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse('http://10.0.2.2:3000/api/auth/login'),
          body: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
        user = User.fromJson(decodedResponse);
        return user;
      } else {
        return 'Login Failed, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: ${e}';
    } finally {
      client.close();
    }
  }
}
