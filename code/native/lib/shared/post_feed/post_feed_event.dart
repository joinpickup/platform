part of 'post_feed_bloc.dart';

abstract class PostFeedEvent extends Equatable {
  @override
  List<Post> get props => [];
}

class RefreshPosts extends PostFeedEvent {}

class LoadPosts extends PostFeedEvent {}

class SearchPosts extends PostFeedEvent {}
