import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/task/bloc/task_one_bloc.dart';
import 'package:project_ninja/features/task/model/task_one_model.dart';

class TaskScreen extends StatefulWidget {
  final String projectId;
  final String taskId;
  const TaskScreen({super.key, required this.projectId, required this.taskId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TaskOneBloc taskOneBloc = TaskOneBloc();

  @override
  void initState() {
    taskOneBloc.add(FetchTaskDetails(taskId: widget.taskId));
    super.initState();
  }

  Widget buildMembers(List<TaskMember> members) {
    if (members.length == 0) {
      return Text("No Members Assigned");
    } else {
      List<Widget> result = [];
      for (int i = 0; i < members.length; i++) {
        result.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(
              members[i].fullname,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
            )),
            (LoginRepo.user.role == "Admin" ||
                    LoginRepo.user.role == "Project Manager" ||
                    LoginRepo.user.role == "Team Lead")
                ? ElevatedButton(
                    onPressed: () {
                      taskOneBloc.add(RemoveMember(
                          taskId: widget.taskId, memberId: members[i].id));
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
      return Column(children: result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task")),
      body: BlocConsumer<TaskOneBloc, TaskOneState>(
        bloc: taskOneBloc,
        listenWhen: (previous, current) => current is TaskOneActionState,
        buildWhen: (previous, current) => current is! TaskOneActionState,
        listener: (context, state) {
          if (state is TaskStatusUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task Status Updated")));
          } else if (state is TaskStatusUpdateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task Status Update Failed")));
          } else if (state is ReloadTask) {
            taskOneBloc.add(FetchTaskDetails(taskId: widget.taskId));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case TaskOneLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TaskOneLoaded:
              final taskLoaded = state as TaskOneLoaded;
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: [
                        const Text('Task ',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('Description: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            Flexible(
                              child: Text(taskLoaded.task.description,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('Status: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                            Flexible(
                              child: Text(taskLoaded.task.status,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            PopupMenuButton(
                              initialValue: taskLoaded.task.status,
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
                                taskOneBloc.add(ChangeStatusTask(
                                    taskId: taskLoaded.task.id, status: item));
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: "Ready to Start",
                                  child: Text('Ready to Start'),
                                ),
                                const PopupMenuItem<String>(
                                  value: "In Progress",
                                  child: Text('In Progress'),
                                ),
                                const PopupMenuItem<String>(
                                  value: "Waiting for Review",
                                  child: Text('Waiting for Review'),
                                ),
                                const PopupMenuItem<String>(
                                  value: "Complete",
                                  child: Text('Complete'),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Row(
                          children: [
                            Text('Members: ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildMembers(taskLoaded.task.assignedTo)
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
