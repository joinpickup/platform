part of 'auth_bloc.dart';

enum AuthStateStatus { authenticated, unauthenticated, error, loading }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStateStatus.unauthenticated,
    required this.personRepository,
    this.user,
    this.error = "",
  });

  final PersonRepository personRepository;
  final AuthStateStatus status;
  final User? user;
  final String error;

  @override
  List<Object?> get props => [status, user];

  AuthState copyWith({
    PersonRepository? personRepository,
    AuthStateStatus? status,
    String? error,
    User? user,
  }) {
    return AuthState(
      personRepository: personRepository ?? this.personRepository,
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
