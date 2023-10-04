part of 'project_bloc.dart';

@immutable
abstract class ProjectState {}

abstract class ProjectActionState extends ProjectState {}

final class ProjectInitialState extends ProjectState {}

class ProjectLoadingState extends ProjectState {}

class ProjectLoadedState extends ProjectState {
  final List<Project> projects;

  ProjectLoadedState({required this.projects});
}

class NoProjectLoadedState extends ProjectState {}
