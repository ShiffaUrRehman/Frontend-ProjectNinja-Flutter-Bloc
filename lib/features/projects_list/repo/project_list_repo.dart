import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

class ProjectListRepo {
  static const String url =
      "https://backend-project-ninja-express-node-type-script.vercel.app";
  static Future<dynamic> fetchProjects() async {
    var client = http.Client();
    String user = '';
    if (LoginRepo.user.role == 'Admin') {
      user = 'admin';
    } else if (LoginRepo.user.role == 'Project Manager') {
      user = 'projectManager';
    } else if (LoginRepo.user.role == 'Team Lead') {
      user = 'teamLead';
    } else if (LoginRepo.user.role == 'Team Member') {
      user = 'teamMember';
    }
    try {
      var response =
          await client.get(Uri.parse('$url/api/project/get/$user'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse.length == 0) {
          return decodedResponse;
        } else {
          List<Project> projects = Project.fromJsonList(decodedResponse);
          return projects;
        }
      } else {
        return 'Failed to Load Projects, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: ${e}';
    } finally {
      client.close();
    }
  }
}
