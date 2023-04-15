import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
          userRepository: userRepository,
          personRepository: personRepository,
        )) {
    on<AppStart>(_onAppStart);
    on<Authenticate>(_onAuthenticate);
    on<Logout>(_onLogout);
  }

  final UserRepository userRepository;
  final PersonRepository personRepository;

  Future<void> _onAppStart(
    AppStart event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AuthStateStatus.loading,
      ),
    );

    String? token = await userRepository.getToken();

    if (token == null) {
      Entity entity = TokenEntity(
          token:
              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2d1aWQiOiIyYjhjNTk5NC0zMTU0LTRiNTEtYTRmMy00MzdkYWVjZDU0ZTYiLCJpZCI6MSwiZXhwIjoxNjgxNTk2MTQwfQ.ZzQ5w3-izekjCYW4RnQ0jgtGHY5x4-2PjPiQn0fVWxc");

      MiddlewareClient client = await entity.newClient(
        event.authEndpoint,
        event.registryEndpoint,
      );

      ServiceInstance authService =
          await client.newServiceInstance("AuthService");
      final usersReq = await authService.newRequest("GET", "/v1/user", null);

      await Future.delayed(const Duration(milliseconds: 250));

      emit(
        state.copyWith(
          user: user1,
          status: AuthStateStatus.authenticated,
        ),
      );
    } else {
      await Future.delayed(const Duration(milliseconds: 250));

      emit(
        state.copyWith(
          status: AuthStateStatus.unauthenticated,
        ),
      );
    }
  }

  Future<void> _onAuthenticate(
    Authenticate event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await state.userRepository.persistToken(event.token);

      User user =
          await state.userRepository.getUserFromToken(token: event.token);

      emit(
        state.copyWith(
          user: user,
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
    await state.userRepository.deleteToken();

    emit(
      state.copyWith(
        user: null,
        status: AuthStateStatus.unauthenticated,
      ),
    );
  }
}
