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
