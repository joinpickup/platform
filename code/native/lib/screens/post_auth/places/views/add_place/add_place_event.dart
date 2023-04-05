part of 'add_place_bloc.dart';

abstract class AddPlaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetAddPlaceValidation extends AddPlaceEvent {}

class AddPost extends AddPlaceEvent {
  AddPost({
    required this.title,
    required this.body,
    required this.interests,
  });

  final String title;
  final String body;
  final List<Interest>? interests;
}
