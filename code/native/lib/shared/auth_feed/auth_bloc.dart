import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/user/user.dart';
import 'package:local/repos/person_repository.dart';
import 'package:local/repos/user_repository.dart';

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
    await Future.delayed(const Duration(milliseconds: 250));

    emit(
      state.copyWith(
        status: AuthStateStatus.unauthenticated,
      ),
    );
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
