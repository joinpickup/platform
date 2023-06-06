part of 'space_filter_modal_bloc.dart';

abstract class SpaceFilterModalEvent extends Equatable {}

class LoadSpaces extends SpaceFilterModalEvent {
  @override
  List<Object?> get props => [];
}

class SaveSpaces extends SpaceFilterModalEvent {
  SaveSpaces({
    required this.spaces,
  });

  final List<Space> spaces;

  @override
  List<Object?> get props => [];
}

class ClearSpaces extends SpaceFilterModalEvent {
  @override
  List<Object?> get props => [];
}
