import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/projects/models/project_model.dart';
import 'package:project_ninja/features/projects/repo/project_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitialState()) {
    on<FetchProjectsEvent>(fetchProjectsEvent);
  }

  FutureOr<void> fetchProjectsEvent(
      FetchProjectsEvent event, Emitter<ProjectState> emit) async {
    emit(ProjectLoadingState());
    dynamic response = await ProjectRepo.fetchProjects();
    if (response.length == 0) {
      emit(NoProjectLoadedState());
    } else {
      emit(ProjectLoadedState(projects: response));
    }
  }
}
