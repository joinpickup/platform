part of 'auth_bloc.dart';

enum AuthStateStatus { authenticated, unauthenticated }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStateStatus.unauthenticated,
    this.userRepository = const UserRepository(),
    required this.personRepository,
    this.user,
  });

  final UserRepository userRepository;
  final PersonRepository personRepository;
  final AuthStateStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];

  AuthState copyWith({
    UserRepository? userRepository,
    PersonRepository? personRepository,
    AuthStateStatus? status,
    User? user,
  }) {
    return AuthState(
      userRepository: userRepository ?? this.userRepository,
      personRepository: personRepository ?? this.personRepository,
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
