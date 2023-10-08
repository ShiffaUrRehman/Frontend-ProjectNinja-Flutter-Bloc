class ProjectMembersModel {
  final String id;
  final String fullname;

  ProjectMembersModel({
    required this.id,
    required this.fullname,
  });

  static ProjectMembersModel fromJson(json) {
    return ProjectMembersModel(
      id: json["_id"],
      fullname: json["fullname"],
    );
  }

  static List<ProjectMembersModel> fromJsonList(jsonList) {
    List<ProjectMembersModel> members = [];
    for (int i = 0; i < jsonList.length; i++) {
      ProjectMembersModel test = fromJson(jsonList[i]);
      members.add(test);
    }

    return members;
  }
}
