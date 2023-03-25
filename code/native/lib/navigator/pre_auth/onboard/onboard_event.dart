part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class HandleNextPage extends OnboardEvent {}

class HandleBackPage extends OnboardEvent {}

class ResetErrors extends OnboardEvent {}

class HandleBasicInfo extends OnboardEvent {
  final String name;

  HandleBasicInfo({
    required this.name,
  });
}

class HandleLocationSettings extends OnboardEvent {}

class HandleInterests extends OnboardEvent {}

class HandleAccountInfo extends OnboardEvent {}

class HandleDonation extends OnboardEvent {}
