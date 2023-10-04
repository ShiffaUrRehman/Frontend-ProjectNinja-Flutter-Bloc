import 'package:flutter/material.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

class ProjectHome extends StatefulWidget {
  final Project project;
  const ProjectHome({super.key, required this.project});

  @override
  State<ProjectHome> createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Home'), // rename project as projectList
      ),
      body: Column(children: [
        Text(LoginRepo.user.id),
        Text(LoginRepo.user.username),
        Text(LoginRepo.user.fullname),
        Text(LoginRepo.user.role),
        Text(LoginRepo.user.token),
        const Text('Project'),
        Text(widget.project.id),
        Text(widget.project.name),
        Text(widget.project.description),
        Text(widget.project.status),
        Text(widget.project.projectManager.fullname),
      ]),
    );
  }
}
