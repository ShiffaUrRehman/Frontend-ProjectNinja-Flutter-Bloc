import 'package:flutter/material.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: Column(children: [
        Text(LoginRepo.user.id),
        Text(LoginRepo.user.username),
        Text(LoginRepo.user.fullname),
        Text(LoginRepo.user.role),
        Text(LoginRepo.user.token),
      ]),
    );
  }
}
