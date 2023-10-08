import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_ninja/features/task/bloc/task_one_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task")),
      body: BlocConsumer<TaskOneBloc, TaskOneState>(
        bloc: taskOneBloc,
        listenWhen: (previous, current) => current is TaskOneActionState,
        buildWhen: (previous, current) => current is! TaskOneActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case TaskOneLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TaskOneLoaded:
              final taskLoaded = state as TaskOneLoaded;
              return Container(
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
                                    fontSize: 20, fontWeight: FontWeight.w400)),
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
                                    fontSize: 20, fontWeight: FontWeight.w400)),
                          ),
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
                    ],
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
