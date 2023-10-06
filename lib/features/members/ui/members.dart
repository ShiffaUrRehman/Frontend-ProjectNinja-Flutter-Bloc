import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/members/bloc/project_members_bloc.dart';
import 'package:project_ninja/features/members/model/members_models.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

class Members extends StatefulWidget {
  final String projectId;
  const Members({super.key, required this.projectId});

  @override
  State<Members> createState() => _MembersState();
}

class _MembersState extends State<Members> {
  ProjectMembersBloc projectMembersBloc = ProjectMembersBloc();
  List<MembersModel> teamLeads = [];
  List<PopupMenuEntry<String>> teamLeadDropDown = [];
  List<MembersModel> teamMembers = [];
  List<PopupMenuEntry<String>> teamMembersDropDown = [];
  late Project project;
  @override
  void initState() {
    projectMembersBloc.add(FetchTeamLeads());
    super.initState();
  }

  List<Widget> buildTeamMembers() {
    List<Widget> result = [];
    for (int i = 0; i < project.teamMember!.length; i++) {
      result.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: Text(
            project.teamMember![i].fullname,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          )),
          (LoginRepo.user.role == "Admin" ||
                  LoginRepo.user.role == "Project Manager")
              ? ElevatedButton(
                  onPressed: () {
                    projectMembersBloc.add(RemoveTeamMember(
                        projectId: project.id,
                        teamMemberId: project.teamMember![i].id));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Remove'),
                )
              : const SizedBox()
        ],
      ));
    }

    return result;
  }

  void buildPopup() {
    teamLeadDropDown = [];
    teamMembersDropDown = [];
    for (int i = 0; i < teamLeads.length; i++) {
      teamLeadDropDown.add(
        PopupMenuItem<String>(
          value: teamLeads[i].id,
          child: Text(teamLeads[i].fullname),
        ),
      );
    }
    for (int i = 0; i < teamMembers.length; i++) {
      teamMembersDropDown.add(
        PopupMenuItem<String>(
          value: teamMembers[i].id,
          child: Text(teamMembers[i].fullname),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: BlocConsumer<ProjectMembersBloc, ProjectMembersState>(
        bloc: projectMembersBloc,
        listenWhen: (previous, current) => current is ProjectMembersActionState,
        buildWhen: (previous, current) => current is! ProjectMembersActionState,
        listener: (context, state) {
          if (state is PageReload) {
            projectMembersBloc.add(FetchProjects(projectId: widget.projectId));
          } else if (state is TeamLeadsFetched) {
            teamLeads = state.members;
            projectMembersBloc.add(FetchTeamMembers());
          } else if (state is TeamMembersFetched) {
            teamMembers = state.members;
            buildPopup();
            projectMembersBloc.add(FetchProjects(projectId: widget.projectId));
          } else if (state is ProjectLoaded) {
            project = state.project;
            projectMembersBloc.add(DisplayProject());
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProjectMembersLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadPage:
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Team Lead: ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w400)),
                            (project.teamLead != null)
                                ? Flexible(
                                    child: Text(
                                    project.teamLead!.fullname,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ))
                                : const Text(
                                    'None',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        (project.teamLead != null)
                            ? (LoginRepo.user.role == "Admin" ||
                                    LoginRepo.user.role == "Project Manager")
                                ? PopupMenuButton(
                                    initialValue: project.teamLead!.fullname,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: const Text(
                                        'Replace',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    onSelected: (String item) {
                                      projectMembersBloc.add(
                                          AddOrReplaceTeamLead(
                                              teamLeadId: item,
                                              projectId: widget.projectId));
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        teamLeadDropDown)
                                : const SizedBox()
                            : (LoginRepo.user.role == "Admin" ||
                                    LoginRepo.user.role == "Project Manager")
                                ? PopupMenuButton(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: const Text(
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    onSelected: (String item) {
                                      projectMembersBloc.add(
                                          AddOrReplaceTeamLead(
                                              teamLeadId: item,
                                              projectId: widget.projectId));
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        teamLeadDropDown)
                                : const SizedBox(),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Team Members: ',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w400)),
                            const SizedBox(
                              width: 20,
                            ),
                            (LoginRepo.user.role == "Admin" ||
                                    LoginRepo.user.role == "Project Manager")
                                ? PopupMenuButton(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: const Text(
                                        'Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    onSelected: (String item) {
                                      projectMembersBloc.add(AddTeamMember(
                                          projectId: project.id,
                                          teamMemberId: item));
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        teamMembersDropDown)
                                : const SizedBox()
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: (project.teamMember != null)
                              ? buildTeamMembers()
                              : [],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            default:
              return const SizedBox(
                child: Center(child: Text("Error")),
              );
          }
        },
      ),
    );
  }
}
