part of 'project_bloc.dart';

@immutable
abstract class ProjectEvent {}

class FetchProjectsAdminEvent extends ProjectEvent {}

class FetchProjectsProjectManagerEvent extends ProjectEvent {}

class FetchProjectsTeamLeadEvent extends ProjectEvent {}

class FetchProjectsTeamMemberEvent extends ProjectEvent {}
