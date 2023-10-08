part of 'task_one_bloc.dart';

@immutable
abstract class TaskOneState {}

abstract class TaskOneActionState extends TaskOneState {}

final class TaskOneInitial extends TaskOneState {}

class TaskOneLoading extends TaskOneState {}

class TaskOneLoaded extends TaskOneState {
  final TaskOne task;

  TaskOneLoaded({required this.task});
}

class TaskOneLoadingFailed extends TaskOneState {}
