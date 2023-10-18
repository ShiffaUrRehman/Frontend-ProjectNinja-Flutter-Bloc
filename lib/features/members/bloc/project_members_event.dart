part of 'project_members_bloc.dart';

@immutable
abstract class ProjectMembersEvent {}

class FetchTeamLeads extends ProjectMembersEvent {}

class FetchTeamMembers extends ProjectMembersEvent {}

class FetchProjects extends ProjectMembersEvent {
  final String projectId;

  FetchProjects({required this.projectId});
}

class DisplayProject extends ProjectMembersEvent {}

class AddOrReplaceTeamLead extends ProjectMembersEvent {
  final String projectId;
  final String teamLeadId;

  AddOrReplaceTeamLead({required this.projectId, required this.teamLeadId});
}

class RemoveTeamMember extends ProjectMembersEvent {
  final String projectId;
  final String teamMemberId;

  RemoveTeamMember({required this.projectId, required this.teamMemberId});
}

class AddTeamMember extends ProjectMembersEvent {
  final String projectId;
  final String teamMemberId;

  AddTeamMember({required this.projectId, required this.teamMemberId});
}
