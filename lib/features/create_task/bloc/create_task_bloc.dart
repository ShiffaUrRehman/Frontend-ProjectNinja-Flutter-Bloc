import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/create_task/model/project_members.dart';
import 'package:project_ninja/features/create_task/repo/create_task_repo.dart';

part 'create_task_event.dart';
part 'create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc() : super(CreateTaskInitial()) {
    on<FetchProjectMembers>(fetchProjectMembers);
    on<DisplayUI>(displayUI);
    on<CreateNewTaskEvent>(createNewTaskEvent);
  }

  FutureOr<void> fetchProjectMembers(
      FetchProjectMembers event, Emitter<CreateTaskState> emit) async {
    emit(Loading());
    dynamic response =
        await CreateTaskRepo.fetchAllProjectMembers(event.projectId);
    if (response is List<ProjectMembersModel>) {
      emit(MembersFetched(members: response));
    } else {
      emit(MembersFetchedFailed());
    }
  }

  FutureOr<void> displayUI(DisplayUI event, Emitter<CreateTaskState> emit) {
    emit(DisplayUIState());
  }

  FutureOr<void> createNewTaskEvent(
      CreateNewTaskEvent event, Emitter<CreateTaskState> emit) async {
    emit(Loading());
    dynamic response = await CreateTaskRepo.createTask(
        event.description, event.assignedTo, event.projectId);
    if (response == 1) {
      emit(TaskCreated());
    } else {
      emit(TaskCreationFailed());
    }
  }
}
