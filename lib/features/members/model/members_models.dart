class MembersModel {
  final String id;
  final String fullname;
  final String role;

  MembersModel({required this.id, required this.fullname, required this.role});

  static MembersModel fromJson(json) {
    return MembersModel(
        id: json["_id"], fullname: json["fullname"], role: json["role"]);
  }

  static List<MembersModel> fromJsonList(jsonList) {
    List<MembersModel> members = [];
    for (int i = 0; i < jsonList.length; i++) {
      MembersModel test = fromJson(jsonList[i]);
      members.add(test);
    }

    return members;
  }
}
