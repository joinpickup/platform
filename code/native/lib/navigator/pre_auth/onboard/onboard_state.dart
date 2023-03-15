part of 'onboard_bloc.dart';

enum OnboardPage {
  basicInfo,
  locationSettings,
  interests,
  accountInfo,
  donation
}

class OnboardState extends Equatable {
  final OnboardPage page;
  final OnboardUser? user;
  final bool onboardDialog;

  const OnboardState({
    required this.page,
    this.onboardDialog = false,
    this.user,
  });

  @override
  List<Object?> get props => [];

  OnboardState copyWith({
    OnboardPage? page,
    OnboardUser? user,
    bool? onboardDialog,
  }) {
    return OnboardState(
      page: page ?? this.page,
      user: user ?? this.user,
      onboardDialog: onboardDialog ?? this.onboardDialog,
    );
  }
}
