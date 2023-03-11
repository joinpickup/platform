import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/models/user.dart';
import 'package:local/repos/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.userRepository})
      : super(AuthState(userRepository: userRepository)) {
    on<AppStart>(_onAppStart);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
  }

  final UserRepository userRepository;

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

  Future<void> _onLogin(
    Login event,
    Emitter<AuthState> emit,
  ) async {
    String token = await state.userRepository
        .authenticate(email: event.email, password: event.password);

    await state.userRepository.persistToken(token);
    emit(
      state.copyWith(
        user: User(email: event.email, password: event.password),
        status: AuthStateStatus.authenticated,
      ),
    );
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
