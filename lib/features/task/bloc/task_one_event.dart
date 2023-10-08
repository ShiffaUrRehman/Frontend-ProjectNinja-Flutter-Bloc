part of 'task_one_bloc.dart';

@immutable
abstract class TaskOneEvent {}

class FetchTaskDetails extends TaskOneEvent {
  final String taskId;

  FetchTaskDetails({required this.taskId});
}

class ChangeStatusTask extends TaskOneEvent {
  final String taskId;
  final String status;

  ChangeStatusTask({required this.status, required this.taskId});
}

class RemoveMember extends TaskOneEvent {
  final String taskId;
  final String memberId;

  RemoveMember({required this.taskId, required this.memberId});
}

class FetchMembersProject extends TaskOneEvent {
  final String projectId;

  FetchMembersProject({required this.projectId});
}

class AddMember extends TaskOneEvent {
  final String taskId;
  final String memberId;

  AddMember({required this.taskId, required this.memberId});
}
