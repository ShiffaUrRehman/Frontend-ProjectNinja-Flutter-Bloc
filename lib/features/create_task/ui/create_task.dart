import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/create_task/bloc/create_task_bloc.dart';
import 'package:project_ninja/features/create_task/model/project_members.dart';
import 'package:project_ninja/features/tasks_home/bloc/tasks_home_bloc.dart';

class CreateTask extends StatefulWidget {
  final String projectId;
  final TasksHomeBloc bloc;
  const CreateTask({super.key, required this.projectId, required this.bloc});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  CreateTaskBloc createTaskBloc = CreateTaskBloc();
  final descriptionController = TextEditingController();
  List<ProjectMembersModel> members = [];
  List<PopupMenuEntry<ProjectMembersModel>> membersDropDown = [];
  List<ProjectMembersModel> membersToBeAdded = [];

  @override
  void initState() {
    createTaskBloc.add(FetchProjectMembers(projectId: widget.projectId));
    super.initState();
  }

  void buildPopup() {
    membersDropDown = [];

    for (int i = 0; i < members.length; i++) {
      membersDropDown.add(
        PopupMenuItem<ProjectMembersModel>(
          value: members[i],
          child: Text(members[i].fullname),
        ),
      );
    }
  }

  Widget buildMembers() {
    if (membersToBeAdded.isEmpty) {
      return const SizedBox();
    } else {
      List<Widget> result = [];
      for (int i = 0; i < membersToBeAdded.length; i++) {
        result.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              membersToBeAdded[i].fullname,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            )),
            ElevatedButton(
              onPressed: () {
                membersToBeAdded.remove(membersToBeAdded[i]);
                createTaskBloc.add(DisplayUI());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Remove'),
            )
          ],
        ));
      }
      return Column(
        children: result,
      );
    }
  }

  List<String> computeAssignedTo() {
    List<String> response = [];
    for (int i = 0; i < membersToBeAdded.length; i++) {
      response.add(membersToBeAdded[i].id);
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Creation')),
      body: BlocConsumer<CreateTaskBloc, CreateTaskState>(
        bloc: createTaskBloc,
        listenWhen: (previous, current) => current is CreateTaskActionState,
        buildWhen: (previous, current) => current is! CreateTaskActionState,
        listener: (context, state) {
          if (state is MembersFetched) {
            members = state.members;
            buildPopup();
            createTaskBloc.add(DisplayUI());
          }
          if (state is TaskCreated) {
            widget.bloc.add(FetchTasks(projectId: widget.projectId));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case Loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case MembersFetchedFailed:
              return const SizedBox(
                child: Center(child: Text("Members Fetch failed")),
              );
            case TaskCreationFailed:
              return const SizedBox(
                child: Center(child: Text("Task Creation failed")),
              );
            case DisplayUIState:
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: Column(children: [
                      const Text('New Task',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w400)),
                      const SizedBox(
                        height: 25,
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Description',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Members',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w400)),
                          PopupMenuButton(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: const Text(
                                  'Add Member',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              onSelected: (ProjectMembersModel item) {
                                if (!membersToBeAdded.contains(item)) {
                                  membersToBeAdded.add(item);
                                  createTaskBloc.add(DisplayUI());
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              "Member already Added to Task")));
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  membersDropDown),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buildMembers(),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          createTaskBloc.add(CreateNewTaskEvent(
                              projectId: widget.projectId,
                              assignedTo: computeAssignedTo(),
                              description: descriptionController.text));
                        },
                        child: const Text('Create Task'),
                      )
                    ])),
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
