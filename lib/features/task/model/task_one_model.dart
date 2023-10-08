class TaskOne {
  final String id;
  final String description;
  final String status;
  final List<TaskMember> assignedTo;
  final String projectId;

  TaskOne(
      {required this.id,
      required this.description,
      required this.status,
      required this.assignedTo,
      required this.projectId});

  static TaskOne fromJson(json) {
    List<TaskMember> members = [];
    if (json["assignedTo"].length != 0) {
      members = TaskMember.fromJsonList(json["assignedTo"]);
    }

    return TaskOne(
        id: json["_id"],
        description: json["description"],
        status: json["status"],
        assignedTo: members,
        projectId: json["projectId"]);
  }
}

class TaskMember {
  final String id;
  final String fullname;

  TaskMember({required this.id, required this.fullname});

  static TaskMember fromJson(json) {
    return TaskMember(id: json["_id"], fullname: json["fullname"]);
  }

  static List<TaskMember> fromJsonList(json) {
    List<TaskMember> members = [];

    for (int i = 0; i < json.length; i++) {
      members.add(TaskMember.fromJson(json[i]));
    }
    return members;
  }
}
