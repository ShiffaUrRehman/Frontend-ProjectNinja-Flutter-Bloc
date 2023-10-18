part of 'tasks_home_bloc.dart';

@immutable
abstract class TasksHomeState {}

abstract class TasksHomeActionState extends TasksHomeState {}

final class TasksHomeInitial extends TasksHomeState {}

class TasksLoading extends TasksHomeState {}

class TasksLoaded extends TasksHomeState {
  final List<Task> tasks;

  TasksLoaded({required this.tasks});
}

class Failed extends TasksHomeState {}
