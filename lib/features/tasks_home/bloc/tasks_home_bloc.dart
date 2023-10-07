import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/tasks_home/model/tasks_model.dart';
import 'package:project_ninja/features/tasks_home/repo/tasks_home_repo.dart';

part 'tasks_home_event.dart';
part 'tasks_home_state.dart';

class TasksHomeBloc extends Bloc<TasksHomeEvent, TasksHomeState> {
  TasksHomeBloc() : super(TasksHomeInitial()) {
    on<FetchTasks>(fetchTasks);
  }

  FutureOr<void> fetchTasks(
      FetchTasks event, Emitter<TasksHomeState> emit) async {
    emit(TasksLoading());
    dynamic response = await TasksHomeRepo.fetchTasksAll(event.projectId);
    print(response);
    if (response is List<Task>) {
      emit(TasksLoaded(tasks: response));
    } else {
      emit(Failed());
    }
  }
}
