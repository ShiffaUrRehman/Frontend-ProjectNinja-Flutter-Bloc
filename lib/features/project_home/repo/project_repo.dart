import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

class ProjectRepo {
  // static const String url = "http://10.0.2.2:3000";
  static const String url = "http://localhost:3000";
  static Future<dynamic> fetchProject(projectId) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('$url/api/project/get/project/$projectId'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));

        Project project = Project.fromJson(decodedResponse);
        return project;
      } else {
        return 'Failed to Load Project, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> changeStatus(status, projectId) async {
    var client = http.Client();
    try {
      var response =
          await client.put(Uri.parse('$url/api/project/status/$projectId'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${LoginRepo.user.token}',
              },
              body: jsonEncode({"status": status}));
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 'Failed to Update Project, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }
}
