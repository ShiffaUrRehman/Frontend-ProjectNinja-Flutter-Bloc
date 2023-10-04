import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/projects/bloc/project_bloc.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  ProjectBloc projectBloc = ProjectBloc();
  @override
  void initState() {
    if (LoginRepo.user.role == 'Admin') {
      projectBloc.add(FetchProjectsAdminEvent());
    } else if (LoginRepo.user.role == 'Project Manager') {
      projectBloc.add(FetchProjectsProjectManagerEvent());
    } else if (LoginRepo.user.role == 'Team Lead') {
      projectBloc.add(FetchProjectsTeamLeadEvent());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
      ),
      body: BlocConsumer<ProjectBloc, ProjectState>(
        bloc: projectBloc,
        listenWhen: (previous, current) => current is ProjectActionState,
        buildWhen: (previous, current) => current is! ProjectActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case NoProjectLoadedState:
              return const Center(
                child: Text('No Projects Available'),
              );
            case ProjectLoadedState:
              final projectsLoaded = state as ProjectLoadedState;
              return ListView.builder(
                  itemCount: projectsLoaded.projects.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        margin: EdgeInsets.all(10),
                        color: Colors.grey.shade300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              projectsLoaded.projects[index].name,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(projectsLoaded.projects[index].status)
                          ],
                        ),
                      ),
                      onTap: () {
                        print(projectsLoaded.projects[index].teamMember);
                        print("Project Clicked");
                      },
                    );
                  });
            case ProjectLoadingState:
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
          ]);
        },
      ),
    );
  }
}
