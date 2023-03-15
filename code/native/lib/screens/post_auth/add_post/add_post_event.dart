part of 'add_post_bloc.dart';

abstract class AddPostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddPost extends AddPostEvent {
  AddPost({required this.post});

  final Post post;
}
