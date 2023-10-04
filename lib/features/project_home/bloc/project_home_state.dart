part of 'project_home_bloc.dart';

@immutable
abstract class ProjectHomeState {}

abstract class ProjectHomeActionState extends ProjectHomeState {}

final class ProjectHomeInitial extends ProjectHomeState {}

class ProjectHomeLoadingState extends ProjectHomeState {}

class ProjectHomeLoadedState extends ProjectHomeState {
  final Project project;

  ProjectHomeLoadedState({required this.project});
}

class ProjectHomeFailedState extends ProjectHomeState {
  final String message;

  ProjectHomeFailedState({required this.message});
}
