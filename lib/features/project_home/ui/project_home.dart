import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/project_home/bloc/project_home_bloc.dart';
import 'package:project_ninja/features/members/ui/members.dart';
import 'package:project_ninja/features/projects_list/bloc/project_bloc.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';
import 'package:project_ninja/features/tasks_home/ui/tasks_home.dart';

class ProjectHome extends StatefulWidget {
  final ProjectListBloc prevBloc;
  final Project project;
  const ProjectHome({super.key, required this.project, required this.prevBloc});

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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                widget.prevBloc.add(FetchProjectsEvent());
              },
            );
          },
        ),
        title: const Text('Project Home'),
      ),
      body: BlocConsumer<ProjectHomeBloc, ProjectHomeState>(
        bloc: projectHomeBloc,
        listenWhen: (previous, current) => current is ProjectHomeActionState,
        buildWhen: (previous, current) => current is! ProjectHomeActionState,
        listener: (context, state) {
          if (state is ProjectHomeReloadState) {
            projectHomeBloc.add(ProjectLoadEvent(projectId: widget.project.id));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProjectHomeLoadedState:
              final projectLoaded = state as ProjectHomeLoadedState;
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
                            projectLoaded.project.name,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Flexible(
                          child: Text(
                            projectLoaded.project.description,
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
                          projectLoaded.project.status,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        (LoginRepo.user.role == 'Admin' ||
                                LoginRepo.user.role == 'Project Manager')
                            ? PopupMenuButton(
                                initialValue: projectLoaded.project.status,
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: const Text(
                                    'Change',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                onSelected: (String item) {
                                  projectHomeBloc.add(ProjectChangeStatusEvent(
                                      status: item,
                                      projectId: widget.project.id));
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: "Onboarding",
                                    child: Text('Onboarding'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: "In Progress",
                                    child: Text('In Progress'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: "Complete",
                                    child: Text('Complete'),
                                  ),
                                ],
                              )
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
                            projectLoaded.project.projectManager.fullname,
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Members(
                                      projectId: projectLoaded.project.id,
                                    ),
                                  ));
                            },
                            child: const Text('View'))
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
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TasksHome(
                                      projectId: projectLoaded.project.id,
                                    ),
                                  ));
                            },
                            child: const Text('View'))
                      ],
                    ),
                  ],
                ),
              );
            case ProjectHomeLoadingState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case ProjectHomeFailedState:
              return const Center(
                child: Text('Failed To Load Project'),
              );
            default:
              return const Center(
                child: Text('Error'),
              );
          }
        },
      ),
    );
  }
}
