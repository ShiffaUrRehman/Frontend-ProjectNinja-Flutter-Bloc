class Project {
  final String id;
  final String name;
  final String description;
  final String status;
  final ProjectUser projectManager;
  late final ProjectUser? teamLead;
  final List<ProjectUser>? teamMember;

  Project(
      {required this.id,
      required this.name,
      required this.description,
      required this.status,
      required this.projectManager,
      this.teamLead,
      required this.teamMember});
  static Project fromJson(dynamic json) {
    var projectManager;
    var teamLead;
    var teamMember = <ProjectUser>[];
    if (json["projectManager"] != null) {
      projectManager = ProjectUser(
          id: json["projectManager"]["_id"],
          fullname: json["projectManager"]["fullname"]);
    }
    if (json["teamLead"] != null) {
      teamLead = ProjectUser(
          id: json["teamLead"]["_id"], fullname: json["teamLead"]["fullname"]);
    }
    if (json["teamMember"] != null) {
      for (int j = 0; j < json["teamMember"].length; j++) {
        teamMember.add(ProjectUser(
            id: json["teamMember"][j]["_id"],
            fullname: json["teamMember"][j]["fullname"]));
      }
    }
    return Project(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        projectManager: projectManager,
        teamLead: teamLead,
        teamMember: teamMember);
  }

  static List<Project> fromJsonList(List<dynamic> json) {
    var projects = <Project>[];
    for (int i = 0; i < json.length; i++) {
      projects.add(Project.fromJson(json[i]));
    }
    return projects;
  }
}

class ProjectUser {
  final String id;
  final String fullname;

  ProjectUser({required this.id, required this.fullname});
}
