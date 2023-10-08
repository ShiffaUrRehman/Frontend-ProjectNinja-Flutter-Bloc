part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskEvent {}

class FetchProjectMembers extends CreateTaskEvent {
  final String projectId;

  FetchProjectMembers({required this.projectId});
}

class DisplayUI extends CreateTaskEvent {}

class CreateNewTaskEvent extends CreateTaskEvent {
  final String description;
  final List<String> assignedTo;
  final String projectId;

  CreateNewTaskEvent(
      {required this.description,
      required this.assignedTo,
      required this.projectId});
}
