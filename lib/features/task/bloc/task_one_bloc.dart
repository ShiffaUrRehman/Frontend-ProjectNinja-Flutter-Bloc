import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'task_one_event.dart';
part 'task_one_state.dart';

class TaskOneBloc extends Bloc<TaskOneEvent, TaskOneState> {
  TaskOneBloc() : super(TaskOneInitial()) {}
}
