part of 'auth_bloc.dart';

enum AuthStateStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStateStatus.unauthenticated,
    this.userRepository = const UserRepository(),
    this.user,
  });

  final UserRepository userRepository;
  final AuthStateStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];

  AuthState copyWith({
    AuthStateStatus? status,
    User? user,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
