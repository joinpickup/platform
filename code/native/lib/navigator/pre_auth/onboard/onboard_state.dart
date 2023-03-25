part of 'onboard_bloc.dart';

enum OnboardPageStatus {
  success,
  error,
  initial,
}

class OnboardState extends Equatable {
  final OnboardPageStatus status;
  final OnboardUser? user;

  const OnboardState({
    this.status = OnboardPageStatus.initial,
    this.user,
  });

  @override
  List<Object?> get props => [status, user];

  OnboardState copyWith({
    OnboardPageStatus? status,
    OnboardUser? user,
  }) {
    return OnboardState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
