part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CancelOnboarding extends OnboardEvent {}

class ConfirmCancel extends OnboardEvent {}

class StopCancel extends OnboardEvent {}

class BackPage extends OnboardEvent {}

class HandleBasicInfo extends OnboardEvent {}

class HandleLocationSettings extends OnboardEvent {}

class HandleInterests extends OnboardEvent {}

class HandleAccountInfo extends OnboardEvent {}

class HandleDonation extends OnboardEvent {}
