import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/create_task/model/project_members.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';

class CreateTaskRepo {
  // static const String url = "http://10.0.2.2:3000";
  static const String url = "http://localhost:3000";
  static Future<dynamic> fetchAllProjectMembers(projectId) async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('$url/api/project/members/$projectId'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        List<ProjectMembersModel> members =
            ProjectMembersModel.fromJsonList(decodedResponse);
        return members;
      } else {
        return 'Failed to Load Members, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> createTask(description, assignedTo, projectId) async {
    var client = http.Client();
    try {
      var response = await client.post(Uri.parse('$url/api/task'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${LoginRepo.user.token}',
          },
          body: jsonEncode({
            'description': description,
            'assignedTo': assignedTo,
            "projectId": projectId
          }));

      if (response.statusCode == 201) {
        return 1;
      } else {
        return 'Failed to Create Task, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }
}
