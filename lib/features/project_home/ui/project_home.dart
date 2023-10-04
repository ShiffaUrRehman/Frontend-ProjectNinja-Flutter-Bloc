import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/project_home/bloc/project_home_bloc.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

class ProjectHome extends StatefulWidget {
  final Project project;
  const ProjectHome({super.key, required this.project});

  @override
  State<ProjectHome> createState() => _ProjectHomeState();
}

class _ProjectHomeState extends State<ProjectHome> {
  ProjectHomeBloc projectHomeBloc = ProjectHomeBloc();
  @override
  void initState() {
    projectHomeBloc.add(ProjectLoadEvent(projectId: widget.project.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Home'),
      ),
      body: BlocConsumer<ProjectHomeBloc, ProjectHomeState>(
        bloc: projectHomeBloc,
        listenWhen: (previous, current) => current is ProjectHomeActionState,
        buildWhen: (previous, current) => current is! ProjectHomeActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case ProjectHomeLoadedState:
              return Container(
                color: Colors.grey.shade300,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text('Name: ',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400)),
                        Flexible(
                          child: Text(
                            widget.project.name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Description: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Flexible(
                          child: Text(
                            widget.project.description,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Status: ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          widget.project.status,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        (LoginRepo.user.role == 'Admin' ||
                                LoginRepo.user.role == 'Project Manager')
                            ? ElevatedButton(
                                onPressed: () {}, child: const Text('Change'))
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Project Manager: ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        Flexible(
                          child: Text(
                            widget.project.projectManager.fullname,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Members ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        const SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('View'))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Text('Tasks ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400)),
                        const SizedBox(
                          width: 80,
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('View'))
                      ],
                    ),
                  ],
                ),
              );
            case ProjectHomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
          }
          return Column(children: [
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
          ]);
        },
      ),
    );
  }
}
