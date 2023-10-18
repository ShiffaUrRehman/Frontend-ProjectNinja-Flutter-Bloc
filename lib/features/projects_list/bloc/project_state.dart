part of 'project_bloc.dart';

@immutable
abstract class ProjectListState {}

abstract class ProjectActionState extends ProjectListState {}

final class ProjectInitialState extends ProjectListState {}

class ProjectLoadingState extends ProjectListState {}

class ProjectLoadedState extends ProjectListState {
  final List<Project> projects;

  ProjectLoadedState({required this.projects});
}

class NoProjectLoadedState extends ProjectListState {}
