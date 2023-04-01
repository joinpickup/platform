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
  });

  final String title;
  final String body;
}
