import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(userRepository)
      : super(
          LoginState(userRepository: userRepository),
        ) {
    on<SubmitLogin>(_onLoginSubmitted);
    on<ResetValidation>(_onResetValidation);
  }

  Future<void> _onLoginSubmitted(
    SubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(event.email);

    // check email
    if (event.email == "" || !emailValid) {
      emit(
        state.copyWith(
          error: LoginError(
            "Please enter a valid email.",
            LoginScreenErrorType.email,
          ),
          status: LoginScreenStatus.error,
        ),
      );
      // check password
    } else if (event.password == "") {
      emit(
        state.copyWith(
          error: LoginError(
            "Please enter a password.",
            LoginScreenErrorType.password,
          ),
          status: LoginScreenStatus.error,
        ),
      );
      // submit login
    } else {
      try {
        String token = await state.userRepository
            .login(email: event.email, password: event.password);

        emit(
          state.copyWith(
            error: null,
            status: LoginScreenStatus.success,
            token: token,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
            error: LoginError(
              e.toString(),
              LoginScreenErrorType.submit,
            ),
            status: LoginScreenStatus.error,
          ),
        );
      }
    }
  }

  Future<void> _onResetValidation(
    ResetValidation event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        error: null,
        status: LoginScreenStatus.initial,
      ),
    );
  }
}
