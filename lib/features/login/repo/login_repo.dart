import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/models/user_model.dart';

class LoginRepo {
  late User user;
  static Future<dynamic> userLogin(String username, String password) async {
    var client = http.Client();
    try {
      var response = await client.post(
          Uri.parse('http://10.0.2.2:3000/api/auth/login'),
          body: {'username': username, 'password': password});
      print(response);
      print(response.statusCode);
      if (response.statusCode == 200) {
      } else {
        return 'Login Failed, status code: ${response.statusCode} ${response.body}';
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(decodedResponse);
      // var uri = Uri.parse(decodedResponse['uri'] as String);
      // print(await client.get(uri));
    } catch (e) {
      return 'Server Error: ${e}';
    } finally {
      client.close();
    }
  }
}
