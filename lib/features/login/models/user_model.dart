class User {
  final String id;
  final String fullname;
  final String username;
  final String role;
  final String token;

  User(
      {required this.id,
      required this.fullname,
      required this.username,
      required this.role,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["user"]["id"],
      fullname: json["user"]["fullname"],
      username: json["user"]["username"],
      role: json["user"]["role"],
      token: json["token"]["token"]);
}
