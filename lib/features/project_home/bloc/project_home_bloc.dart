import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'project_home_event.dart';
part 'project_home_state.dart';

class ProjectHomeBloc extends Bloc<ProjectHomeEvent, ProjectHomeState> {
  ProjectHomeBloc() : super(ProjectHomeInitial()) {
    on<ProjectHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
