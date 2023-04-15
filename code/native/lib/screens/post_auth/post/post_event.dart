part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPost extends PostEvent {
  LoadPost({required this.postID});

  final int postID;
}

class LoadComments extends PostEvent {
  LoadComments({required this.postID});

  final int postID;
}
