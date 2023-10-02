import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:project_ninja/features/login/models/user_model.dart';
import 'package:project_ninja/features/login/repo/login_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginUserEvent>(loginUser);
  }

  FutureOr<void> loginUser(
      LoginUserEvent event, Emitter<LoginState> emit) async {
    // emit(LoginLoadingState());
    dynamic response =
        await LoginRepo.userLogin(event.username, event.password);
    if (response is User) {
      // emit(LoginSuccessState());
    } else {
      emit(LoginFailedState(message: response));
    }
  }
}
