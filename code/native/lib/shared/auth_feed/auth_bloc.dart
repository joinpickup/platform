import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/mocks/user.dart';
import 'package:local/repos/data/models/user/user.dart';
import 'package:local/repos/person_repository.dart';
import 'package:local/repos/user_repository.dart';
import 'package:local/util/middleware/middleware.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.userRepository,
    required this.personRepository,
  }) : super(AuthState(
          personRepository: personRepository,
        )) {
    on<Authenticate>(_onAuthenticate);
    on<Logout>(_onLogout);
  }

  final UserRepository userRepository;
  final PersonRepository personRepository;

  Future<void> _onAuthenticate(
    Authenticate event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await userRepository.persistToken(event.token);

      emit(
        state.copyWith(
          user: user1,
          status: AuthStateStatus.authenticated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          user: null,
          status: AuthStateStatus.error,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<AuthState> emit,
  ) async {
    await userRepository.deleteToken();

    emit(
      state.copyWith(
        user: null,
        status: AuthStateStatus.unauthenticated,
      ),
    );
  }
}
