part of 'login_bloc.dart';

enum LoginScreenStatus {
  error,
  initial,
  success,
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginScreenStatus.initial,
    required this.userRepository,
    this.token,
    this.error,
  });

  final LoginScreenStatus status;
  final UserRepository userRepository;
  final String? error;
  final String? token;

  @override
  List<Object?> get props => [status, userRepository, error, token];

  LoginState copyWith({
    LoginScreenStatus? status,
    UserRepository? userRepository,
    String? error,
    String? token,
  }) {
    return LoginState(
      status: status ?? this.status,
      token: token ?? this.token,
      userRepository: userRepository ?? this.userRepository,
      error: error ?? this.error,
    );
  }
}
