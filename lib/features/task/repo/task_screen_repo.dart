import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/task/model/task_one_model.dart';

class TasksScreenRepo {
  static const String url =
      "https://backend-project-ninja-express-node-type-script.vercel.app";

  static Future<dynamic> fetchTask(taskId) async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse('$url/api/task/get/$taskId'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        TaskOne task = TaskOne.fromJson(decodedResponse);
        return task;
      } else {
        return 'Failed to Load TeamLeads, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> changeStatus(taskId, status) async {
    var client = http.Client();
    try {
      var response = await client.put(Uri.parse('$url/api/task/status/$taskId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${LoginRepo.user.token}',
          },
          body: jsonEncode({
            'status': status,
          }));
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 'Failed to Update Status of Task, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> removeMember(taskId, memberId) async {
    var client = http.Client();
    try {
      var response =
          await client.put(Uri.parse('$url/api/task/removeMember/$taskId'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${LoginRepo.user.token}',
              },
              body: jsonEncode({
                'member': memberId,
              }));
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 'Failed to Update Status of Task, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

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
        List<TaskMember> members = TaskMember.fromJsonList(decodedResponse);
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

  static Future<dynamic> addMember(taskId, memberId) async {
    var client = http.Client();
    try {
      var response =
          await client.put(Uri.parse('$url/api/task/addMember/$taskId'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${LoginRepo.user.token}',
              },
              body: jsonEncode({
                'member': memberId,
              }));
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 'Failed to Update Status of Task, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }
}
