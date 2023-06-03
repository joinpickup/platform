part of 'space_bloc.dart';

abstract class SpaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSpaces extends SpaceEvent {}

class ChangeSpace extends SpaceEvent {
  final Space space;

  ChangeSpace(
    this.space,
  );
}
