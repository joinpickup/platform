part of 'login_bloc.dart';

enum LoginScreenStatus {
  error,
  initial,
  success,
}

enum LoginScreenErrorType {
  email,
  password,
  submit,
}

class LoginError extends Equatable {
  final String error;
  final LoginScreenErrorType errorType;

  const LoginError(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
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
  final LoginError? error;
  final String? token;

  @override
  List<Object?> get props => [status, userRepository, error, token];

  LoginState copyWith({
    LoginScreenStatus? status,
    UserRepository? userRepository,
    LoginError? error,
    String? token,
  }) {
    return LoginState(
      status: status ?? this.status,
      userRepository: userRepository ?? this.userRepository,
      error: error ?? this.error,
      token: token ?? this.token,
    );
  }
}
