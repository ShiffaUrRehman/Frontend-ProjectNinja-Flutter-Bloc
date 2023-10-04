import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/projects/models/project_model.dart';
import 'package:project_ninja/features/projects/repo/project_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitialState()) {
    on<FetchProjectsAdminEvent>(fetchProjectsAdminEvent);
    on<FetchProjectsProjectManagerEvent>(fetchProjectsProjectManagerEvent);
  }

  FutureOr<void> fetchProjectsAdminEvent(
      FetchProjectsAdminEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoadingState());
    dynamic response = await ProjectRepo.fetchProjectsAdmin();
    if (response.length == 0) {
      emit(NoProjectLoadedState());
    } else {
      emit(ProjectLoadedState(projects: response));
    }
  }

  FutureOr<void> fetchProjectsProjectManagerEvent(
      FetchProjectsProjectManagerEvent event,
      Emitter<ProjectState> emit) async {
    emit(ProjectLoadingState());
    dynamic response = await ProjectRepo.fetchProjectsProjectManager();
    if (response.length == 0) {
      emit(NoProjectLoadedState());
    } else {
      emit(ProjectLoadedState(projects: response));
    }
  }
}
