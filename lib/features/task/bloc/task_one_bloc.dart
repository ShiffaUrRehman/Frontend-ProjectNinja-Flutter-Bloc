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
}
