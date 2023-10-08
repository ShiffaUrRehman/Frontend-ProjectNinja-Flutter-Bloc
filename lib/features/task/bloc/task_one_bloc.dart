import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/task/model/task_one_model.dart';
import 'package:project_ninja/features/task/repo/task_screen_repo.dart';

part 'task_one_event.dart';
part 'task_one_state.dart';

class TaskOneBloc extends Bloc<TaskOneEvent, TaskOneState> {
  TaskOneBloc() : super(TaskOneInitial()) {
    on<FetchTaskDetails>(fetchTaskDetails);
    on<ChangeStatusTask>(changeStatusTask);
    on<RemoveMember>(removeMember);
    on<FetchMembersProject>(fetchMembersProject);
    on<AddMember>(addMember);
  }

  FutureOr<void> fetchTaskDetails(
      FetchTaskDetails event, Emitter<TaskOneState> emit) async {
    emit(TaskOneLoading());
    dynamic response = await TasksScreenRepo.fetchTask(event.taskId);
    if (response is TaskOne) {
      emit(TaskOneLoaded(task: response));
    } else {
      emit(TaskOneLoadingFailed());
    }
  }

  FutureOr<void> changeStatusTask(
      ChangeStatusTask event, Emitter<TaskOneState> emit) async {
    emit(TaskOneLoading());
    dynamic response =
        await TasksScreenRepo.changeStatus(event.taskId, event.status);
    if (response == 1) {
      emit(ReloadTask());
    } else {
      emit(TaskStatusUpdateFailed());
    }
  }

  FutureOr<void> removeMember(
      RemoveMember event, Emitter<TaskOneState> emit) async {
    emit(TaskOneLoading());
    dynamic response =
        await TasksScreenRepo.removeMember(event.taskId, event.memberId);
    if (response == 1) {
      emit(ReloadTask());
    } else {
      emit(TaskStatusUpdateFailed());
    }
  }

  FutureOr<void> fetchMembersProject(
      FetchMembersProject event, Emitter<TaskOneState> emit) async {
    emit(TaskOneLoading());
    dynamic response =
        await TasksScreenRepo.fetchAllProjectMembers(event.projectId);
    if (response is List<TaskMember>) {
      emit(MembersTaskLoaded(members: response));
    } else {
      emit(MembersTaskLoadFailed());
    }
  }

  FutureOr<void> addMember(AddMember event, Emitter<TaskOneState> emit) async {
    emit(TaskOneLoading());
    dynamic response =
        await TasksScreenRepo.addMember(event.taskId, event.memberId);
    if (response == 1) {
      emit(ReloadTask());
    } else {
      emit(TaskStatusUpdateFailed());
    }
  }
}
