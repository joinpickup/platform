part of 'account_info_bloc.dart';

enum AccountInfoPageStatus { error, initial, success }

enum AccountInfoPageErrorType { email, password, register }

class AccountInfoError extends Equatable {
  final String error;
  final AccountInfoPageErrorType errorType;

  const AccountInfoError(this.error, this.errorType);

  @override
  List<Object?> get props => [error, errorType];
}

class AccountInfoPageState extends Equatable {
  final String? email;
  final String? password;
  final String? token;
  final AccountInfoError? error;
  final AccountInfoPageStatus status;

  final UserRepository userRepository;

  const AccountInfoPageState({
    required this.userRepository,
    this.password,
    this.token,
    this.email,
    this.error,
    this.status = AccountInfoPageStatus.initial,
  });

  @override
  List<Object?> get props => [email, status, error];

  AccountInfoPageState copyWith({
    String? email,
    String? password,
    String? token,
    AccountInfoError? error,
    AccountInfoPageStatus? status,
    UserRepository? userRepository,
  }) {
    return AccountInfoPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
      error: error ?? this.error,
      status: status ?? this.status,
      userRepository: userRepository ?? this.userRepository,
    );
  }
}
