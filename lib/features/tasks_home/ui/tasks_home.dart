import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/create_task/ui/create_task.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';
import 'package:project_ninja/features/task/ui/task_screen.dart';
import 'package:project_ninja/features/tasks_home/bloc/tasks_home_bloc.dart';

class TasksHome extends StatefulWidget {
  final String projectId;
  const TasksHome({super.key, required this.projectId});

  @override
  State<TasksHome> createState() => _TasksHomeState();
}

class _TasksHomeState extends State<TasksHome> {
  TasksHomeBloc tasksHomeBloc = TasksHomeBloc();

  @override
  void initState() {
    tasksHomeBloc.add(FetchTasks(projectId: widget.projectId));
    super.initState();
  }

  List<Widget> buildTasks(tasks) {
    if (tasks.length != 0) {
      List<Widget> result = [];
      for (int i = 0; i < tasks.length; i++) {
        result.add(InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskScreen(
                      projectId: widget.projectId, taskId: tasks[i].id),
                ));
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            color: Colors.grey.shade400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text(tasks[i].description,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400))),
                Text(
                  tasks[i].status,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ));
      }
      return result;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tasks"),
      ),
      body: BlocConsumer<TasksHomeBloc, TasksHomeState>(
        bloc: tasksHomeBloc,
        listenWhen: (previous, current) => current is TasksHomeActionState,
        buildWhen: (previous, current) => current is! TasksHomeActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case TasksLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TasksLoaded:
              final tasksLoaded = state as TasksLoaded;
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey.shade300,
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Tasks",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w400)),
                        (LoginRepo.user.role == "Admin" ||
                                LoginRepo.user.role == "Project Manager" ||
                                LoginRepo.user.role == "Team Lead")
                            ? ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CreateTask(
                                              projectId: widget.projectId,
                                              bloc: tasksHomeBloc)));
                                },
                                child: const Text("Add New"))
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(height: 20),
                    (tasksLoaded.tasks.isEmpty)
                        ? const Center(
                            child: Text('No Tasks to show'),
                          )
                        : SingleChildScrollView(
                            child:
                                Column(children: buildTasks(tasksLoaded.tasks)),
                          )
                  ]),
                ),
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
