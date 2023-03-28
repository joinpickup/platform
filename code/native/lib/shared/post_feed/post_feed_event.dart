part of 'post_feed_bloc.dart';

abstract class PostFeedEvent extends Equatable {
  @override
  List<Post> get props => [];
}

class RefreshPosts extends PostFeedEvent {
  RefreshPosts({required this.refreshController});

  final RefreshController refreshController;
}

class LoadPostsPost extends PostFeedEvent {
  LoadPostsPost({this.refreshController});

  final RefreshController? refreshController;
}

class SearchPosts extends PostFeedEvent {
  SearchPosts({required this.context, required this.query});

  final BuildContext context;
  final String query;
}
