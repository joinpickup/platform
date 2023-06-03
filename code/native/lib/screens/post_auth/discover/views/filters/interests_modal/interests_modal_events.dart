part of 'interests_modal_bloc.dart';

abstract class InterestsModalEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToggleInterstsModal extends InterestsModalEvent {
  final Interest interest;

  ToggleInterstsModal(this.interest);
}
