part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HandleNextPage extends OnboardEvent {}

class HandleBasicInfo extends OnboardEvent {}

class HandleLocationSettings extends OnboardEvent {}

class HandleInterests extends OnboardEvent {}

class HandleAccountInfo extends OnboardEvent {}

class HandleDonation extends OnboardEvent {}
