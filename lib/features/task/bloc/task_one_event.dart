part of 'task_one_bloc.dart';

@immutable
abstract class TaskOneEvent {}

class FetchTaskDetails extends TaskOneEvent {
  final String taskId;

  FetchTaskDetails({required this.taskId});
}
