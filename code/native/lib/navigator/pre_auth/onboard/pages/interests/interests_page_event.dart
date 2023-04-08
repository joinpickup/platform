part of 'interests_page_bloc.dart';

abstract class InterestsPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleInterest extends InterestsPageEvent {
  final Interest interest;

  ToggleInterest(this.interest);
}

class SubmitInterests extends InterestsPageEvent {}

class ResetValidation extends InterestsPageEvent {}
