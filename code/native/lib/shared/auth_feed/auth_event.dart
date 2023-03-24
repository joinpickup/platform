part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStart extends AuthEvent {}

class Login extends AuthEvent {
  Login({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class Authenticate extends AuthEvent {
  Authenticate({
    required this.token,
  });

  final String token;
}

class Logout extends AuthEvent {}
