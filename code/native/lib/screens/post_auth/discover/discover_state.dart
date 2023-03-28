part of 'discover_bloc.dart';

enum DiscoverScreenStatus { searching, init, error }

enum DiscoverFeedStatus { loading, error, success }

enum DiscoverScreenErrorType { loading }

class DiscoverScreenError {
  final String error;
  final DiscoverScreenErrorType errorType;

  DiscoverScreenError(this.error, this.errorType);
}

class DiscoverScreenState extends Equatable {
  final DiscoverFeedStatus feedStatus;
  final DiscoverScreenStatus screenStatus;
  final List<Post>? posts;
  final DiscoverScreenError? error;

  final PostRepository postRepository;

  const DiscoverScreenState({
    this.feedStatus = DiscoverFeedStatus.loading,
    this.screenStatus = DiscoverScreenStatus.init,
    this.posts,
    this.error,
    required this.postRepository,
  });

  @override
  List<Object?> get props => [feedStatus, screenStatus, posts, error];

  DiscoverScreenState copyWith({
    DiscoverFeedStatus? feedStatus,
    DiscoverScreenStatus? screenStatus,
    List<Post>? posts,
    DiscoverScreenError? error,
    PostRepository? postRepository,
  }) {
    return DiscoverScreenState(
      feedStatus: feedStatus ?? this.feedStatus,
      screenStatus: screenStatus ?? this.screenStatus,
      posts: posts ?? this.posts,
      error: error ?? this.error,
      postRepository: postRepository ?? this.postRepository,
    );
  }
}
