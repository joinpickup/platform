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
  final List<Post>? postFeed;
  final List<Post>? postSearch;
  final DiscoverScreenError? error;

  final PostRepository postRepository;

  const DiscoverScreenState({
    this.feedStatus = DiscoverFeedStatus.loading,
    this.screenStatus = DiscoverScreenStatus.init,
    this.postFeed,
    this.postSearch,
    this.error,
    required this.postRepository,
  });

  @override
  List<Object?> get props =>
      [feedStatus, screenStatus, postFeed, postSearch, error];

  DiscoverScreenState copyWith({
    DiscoverFeedStatus? feedStatus,
    DiscoverScreenStatus? screenStatus,
    List<Post>? postFeed,
    List<Post>? postSearch,
    DiscoverScreenError? error,
    PostRepository? postRepository,
  }) {
    return DiscoverScreenState(
      feedStatus: feedStatus ?? this.feedStatus,
      screenStatus: screenStatus ?? this.screenStatus,
      postFeed: postFeed ?? this.postFeed,
      postSearch: postSearch ?? this.postSearch,
      error: error ?? this.error,
      postRepository: postRepository ?? this.postRepository,
    );
  }
}
