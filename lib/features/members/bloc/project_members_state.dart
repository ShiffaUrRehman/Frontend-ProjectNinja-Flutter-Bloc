part of 'project_members_bloc.dart';

@immutable
abstract class ProjectMembersState {}

abstract class ProjectMembersActionState extends ProjectMembersState {}

final class ProjectMembersInitial extends ProjectMembersState {}

class TeamLeadsFetched extends ProjectMembersActionState {
  final List<MembersModel> members;

  TeamLeadsFetched({required this.members});
}

class TeamMembersFetched extends ProjectMembersActionState {
  final List<MembersModel> members;

  TeamMembersFetched({required this.members});
}

class TeamLeadsFetchedFailed extends ProjectMembersActionState {}

class TeamMembersFetchedFailed extends ProjectMembersActionState {}

class ProjectMembersLoading extends ProjectMembersState {}

class ProjectLoaded extends ProjectMembersActionState {
  final Project project;

  ProjectLoaded({required this.project});
}

class LoadPage extends ProjectMembersState {}

class PageReload extends ProjectMembersActionState {}

class Failed extends ProjectMembersState {}
