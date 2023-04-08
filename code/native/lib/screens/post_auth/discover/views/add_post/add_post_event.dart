part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetAddPostValidation extends AddPostEvent {}

class AddPost extends AddPostEvent {
  AddPost({
    required this.title,
    required this.body,
    required this.interests,
  });

  final String title;
  final String body;
  final List<Interest>? interests;
}
