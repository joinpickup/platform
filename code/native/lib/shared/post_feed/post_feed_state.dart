part of "post_feed_bloc.dart";

enum PostFeedStatus { loading, success, failure }

class PostFeedState extends Equatable {
  const PostFeedState({
    this.status = PostFeedStatus.loading,
    required this.postRepository,
    this.posts = const <Post>[],
    this.error = "",
  });

  final PostFeedStatus status;
  final PostRepository postRepository;
  final List<Post> posts;
  final String error;

  @override
  List<Object> get props => [status, posts, error];

  PostFeedState copyWith({
    PostFeedStatus? status,
    PostRepository? postRepository,
    List<Post>? posts,
    String? error,
  }) {
    return PostFeedState(
      status: status ?? this.status,
      postRepository: postRepository ?? this.postRepository,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }
}
