import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';
import 'package:project_ninja/features/projects_list/repo/project_list_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectListBloc extends Bloc<ProjectListEvent, ProjectListState> {
  ProjectListBloc() : super(ProjectInitialState()) {
    on<FetchProjectsEvent>(fetchProjectsEvent);
  }

  FutureOr<void> fetchProjectsEvent(
      FetchProjectsEvent event, Emitter<ProjectListState> emit) async {
    emit(ProjectLoadingState());
    dynamic response = await ProjectListRepo.fetchProjects();
    if (response.length == 0) {
      emit(NoProjectLoadedState());
    } else {
      emit(ProjectLoadedState(projects: response));
    }
  }
}
