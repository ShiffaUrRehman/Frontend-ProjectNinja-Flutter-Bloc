import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/members/model/members_models.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

class MembersRepo {
  static const String url =
      "https://backend-project-ninja-express-node-type-script.vercel.app";
  static Future<dynamic> fetchAllTeamLeads() async {
    var client = http.Client();
    try {
      var response =
          await client.get(Uri.parse('$url/api/users/get/teamLeads'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        List<MembersModel> members = MembersModel.fromJsonList(decodedResponse);
        return members;
      } else {
        return 'Failed to Load TeamLeads, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> fetchAllTeamMembers() async {
    var client = http.Client();
    try {
      var response = await client
          .get(Uri.parse('$url/api/users/get/teamMembers'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${LoginRepo.user.token}',
      });
      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        List<MembersModel> members = MembersModel.fromJsonList(decodedResponse);
        return members;
      } else {
        return 'Failed to Load TeamLeads, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

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

  static Future<dynamic> addOrReplaceTeamLeadProject(
      teamLead, projectId) async {
    var client = http.Client();
    try {
      var response = await client.put(
          Uri.parse('$url/api/project/add/teamLead/$projectId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${LoginRepo.user.token}',
          },
          body: jsonEncode({"teamLead": teamLead}));
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 'Failed to Add/Replace Team Lead in Project, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> removeTeamMemberProject(teamMember, projectId) async {
    var client = http.Client();
    try {
      var response = await client.put(
          Uri.parse('$url/api/project/teamMember/remove/$projectId'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${LoginRepo.user.token}',
          },
          body: jsonEncode({"teamMember": teamMember}));
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 'Failed to Add/Replace Team Lead in Project, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }

  static Future<dynamic> addTeamMemberProject(teamMember, projectId) async {
    var client = http.Client();
    try {
      var response =
          await client.put(Uri.parse('$url/api/project/teamMember/$projectId'),
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${LoginRepo.user.token}',
              },
              body: jsonEncode({"teamMember": teamMember}));
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 'Failed to Add/Replace Team Lead in Project, status code: ${response.statusCode} ${response.body}';
      }
    } catch (e) {
      return 'Server Error: $e';
    } finally {
      client.close();
    }
  }
}
