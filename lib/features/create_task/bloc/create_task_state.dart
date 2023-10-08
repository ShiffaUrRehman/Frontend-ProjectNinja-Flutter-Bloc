part of 'create_task_bloc.dart';

@immutable
abstract class CreateTaskState {}

abstract class CreateTaskActionState extends CreateTaskState {}

final class CreateTaskInitial extends CreateTaskState {}

class Loading extends CreateTaskState {}

class MembersFetched extends CreateTaskActionState {
  final List<ProjectMembersModel> members;

  MembersFetched({required this.members});
}

class MembersFetchedFailed extends CreateTaskState {}

class DisplayUIState extends CreateTaskState {}

class TaskCreated extends CreateTaskActionState {}

class TaskCreationFailed extends CreateTaskActionState {}
