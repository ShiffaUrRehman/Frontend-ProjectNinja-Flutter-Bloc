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

  static List<Project> fromJson(List<dynamic> json) {
    var projects = <Project>[];
    for (int i = 0; i < json.length; i++) {
      var projectManager;
      var teamLead;
      var teamMember = <ProjectUser>[];
      if (json[i]["projectManager"] != null) {
        projectManager = ProjectUser(
            id: json[i]["projectManager"]["_id"],
            fullname: json[i]["projectManager"]["fullname"]);
      }
      if (json[i]["teamLead"] != null) {
        teamLead = ProjectUser(
            id: json[i]["teamLead"]["_id"],
            fullname: json[i]["teamLead"]["fullname"]);
      }
      if (json[i]["teamMember"] != null) {
        for (int j = 0; j < json[i]["teamMember"].length; j++) {
          teamMember.add(ProjectUser(
              id: json[i]["teamMember"][j]["_id"],
              fullname: json[i]["teamMember"][j]["fullname"]));
        }
      }
      projects.add(Project(
          id: json[i]["_id"],
          name: json[i]["name"],
          description: json[i]["description"],
          status: json[i]["status"],
          projectManager: projectManager,
          teamLead: teamLead,
          teamMember: teamMember));
    }
    return projects;
  }
}

class ProjectUser {
  final String id;
  final String fullname;

  ProjectUser({required this.id, required this.fullname});
}
