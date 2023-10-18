part of 'tasks_home_bloc.dart';

@immutable
abstract class TasksHomeEvent {}

class FetchTasks extends TasksHomeEvent {
  final String projectId;

  FetchTasks({required this.projectId});
}
