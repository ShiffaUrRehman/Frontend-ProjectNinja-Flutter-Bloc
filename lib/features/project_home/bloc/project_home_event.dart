part of 'project_home_bloc.dart';

@immutable
abstract class ProjectHomeEvent {}

class ProjectLoadEvent extends ProjectHomeEvent {
  final String projectId;

  ProjectLoadEvent({required this.projectId});
}

class ProjectChangeStatusEvent extends ProjectHomeEvent {
  final String status;
  final String projectId;

  ProjectChangeStatusEvent({required this.status, required this.projectId});
}
