part of 'project_home_bloc.dart';

@immutable
abstract class ProjectHomeEvent {}

class ProjectLoadEvent extends ProjectHomeEvent {
  final String projectId;

  ProjectLoadEvent({required this.projectId});
}
