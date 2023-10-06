import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  final String projectId;
  final String taskId;
  const TaskScreen({super.key, required this.projectId, required this.taskId});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task")),
    );
  }
}
