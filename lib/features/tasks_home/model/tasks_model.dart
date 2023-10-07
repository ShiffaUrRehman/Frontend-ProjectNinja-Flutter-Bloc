class Task {
  final String id;
  final String description;
  final String status;

  Task({
    required this.id,
    required this.description,
    required this.status,
  });

  static Task fromJson(json) {
    // dynamic assignedTo = [];
    // if (json["assignedTo"].length != 0) {
    //   assignedTo = MembersTaskModel.fromJsonList(json["assignedTo"]);
    // }

    return Task(
        id: json["_id"],
        description: json["description"],
        status: json["status"]);
  }

  static List<Task> fromJsonList(jsonList) {
    List<Task> response = [];
    for (int i = 0; i < jsonList.length; i++) {
      response.add(fromJson(jsonList[i]));
    }
    return response;
  }
}

// class MembersTaskModel {
//   final String id;
//   final String fullname;

//   MembersTaskModel({required this.id, required this.fullname});

//   static MembersTaskModel fromJson(json) {
//     return MembersTaskModel(id: json["_id"], fullname: json["fullname"]);
//   }

//   static List<MembersTaskModel> fromJsonList(jsonList) {
//     List<MembersTaskModel> members = [];
//     for (int i = 0; i < jsonList.length; i++) {
//       MembersTaskModel test = fromJson(jsonList[i]);
//       members.add(test);
//     }

//     return members;
//   }
// }
