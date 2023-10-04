import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/projects/models/project_model.dart';

class ProjectRepo {
  static const String url = "http://10.0.2.2:3000";
  static Future<dynamic> fetchProjectsAdmin() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse('$url/api/project/get/admin'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse.length == 0) {
          return decodedResponse;
        } else {
          List<Project> projects = Project.fromJson(decodedResponse);
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

  static Future<dynamic> fetchProjectsProjectManager() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('$url/api/project/get/projectManager'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse.length == 0) {
          return decodedResponse;
        } else {
          List<Project> projects = Project.fromJson(decodedResponse);
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

  static Future<dynamic> fetchProjectsTeamLead() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('$url/api/project/get/teamLead'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse.length == 0) {
          return decodedResponse;
        } else {
          List<Project> projects = Project.fromJson(decodedResponse);
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

  static Future<dynamic> fetchProjectsTeamMember() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('$url/api/project/get/teamMember'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        if (decodedResponse.length == 0) {
          return decodedResponse;
        } else {
          List<Project> projects = Project.fromJson(decodedResponse);
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
