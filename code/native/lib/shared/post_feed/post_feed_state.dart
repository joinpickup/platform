part of "post_feed_bloc.dart";

enum PostFeedStatus { loading, success, failure }

class PostFeedState extends Equatable {
  const PostFeedState({
    this.status = PostFeedStatus.loading,
    this.posts = const <Post>[],
    this.error = "",
  });

  final PostFeedStatus status;
  final List<Post> posts;
  final String error;

  @override
  List<Object> get props => [status, posts, error];

  PostFeedState copyWith({
    PostFeedStatus? status,
    List<Post>? posts,
  }) {
    return PostFeedState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
    );
  }
}
