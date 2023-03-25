part of 'onboard_bloc.dart';

enum OnboardPageStatus {
  success,
  error,
  initial,
}

class OnboardState extends Equatable {
  final OnboardPageStatus status;
  final OnboardUser? user;
  final String? error;

  const OnboardState({
    this.status = OnboardPageStatus.initial,
    this.error,
    this.user,
  });

  @override
  List<Object?> get props => [status, user, error];

  OnboardState copyWith({
    OnboardPageStatus? status,
    OnboardUser? user,
    String? error,
  }) {
    return OnboardState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
