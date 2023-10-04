import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/project_home/repo/project_repo.dart';
import 'package:project_ninja/features/projects_list/bloc/project_bloc.dart';
import 'package:project_ninja/features/projects_list/models/project_model.dart';

part 'project_home_event.dart';
part 'project_home_state.dart';

class ProjectHomeBloc extends Bloc<ProjectHomeEvent, ProjectHomeState> {
  ProjectHomeBloc() : super(ProjectHomeInitial()) {
    on<ProjectLoadEvent>(projectLoadEvent);
    on<ProjectChangeStatusEvent>(projectChangeStatusEvent);
  }

  FutureOr<void> projectLoadEvent(
      ProjectLoadEvent event, Emitter<ProjectHomeState> emit) async {
    emit(ProjectHomeLoadingState());
    dynamic response = await ProjectRepo.fetchProject(event.projectId);
    if (response is Project) {
      emit(ProjectHomeLoadedState(project: response));
    } else {
      emit(ProjectHomeFailedState(message: response));
    }
  }

  FutureOr<void> projectChangeStatusEvent(
      ProjectChangeStatusEvent event, Emitter<ProjectHomeState> emit) async {
    emit(ProjectHomeLoadingState());
    dynamic response =
        await ProjectRepo.changeStatus(event.status, event.projectId);
    if (response == 1) {
      emit(ProjectHomeReloadState());
    } else {
      emit(ProjectHomeFailedState(message: response));
    }
  }
}
