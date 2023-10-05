import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/models/user_model.dart';

class LoginRepo {
  // static const String url = "http://10.0.2.2:3000";
  static const String url = "http://localhost:3000";
  static late User user;

  static Future<dynamic> userLogin(String username, String password) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('$url/api/auth/login'),
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
