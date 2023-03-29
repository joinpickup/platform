part of 'discover_bloc.dart';

enum DiscoverScreenStatus { searching, init, error }

enum DiscoverFeedStatus { loading, error, success }

enum DiscoverScreenErrorType { loading }

class DiscoverScreenError {
  final String error;
  final DiscoverScreenErrorType errorType;

  DiscoverScreenError(this.error, this.errorType);
}

class DiscoverAgeFilterState extends Equatable {
  final bool filterStatus;
  final int start;
  final int end;

  const DiscoverAgeFilterState({
    required this.filterStatus,
    this.start = kAgeFilterStart,
    this.end = kAgeFilterEnd,
  });

  @override
  List<Object?> get props => [filterStatus, start, end];
}

class DiscoverScreenState extends Equatable {
  final DiscoverFeedStatus feedStatus;
  final DiscoverScreenStatus screenStatus;
  final List<Post>? postFeed;
  final List<Post>? postSearch;
  final DiscoverScreenError? error;

  final DiscoverAgeFilterState ageFilter;

  final PostRepository postRepository;

  const DiscoverScreenState({
    this.feedStatus = DiscoverFeedStatus.loading,
    this.screenStatus = DiscoverScreenStatus.init,
    this.postFeed,
    this.postSearch,
    this.error,
    this.ageFilter = const DiscoverAgeFilterState(filterStatus: false),
    required this.postRepository,
  });

  @override
  List<Object?> get props =>
      [feedStatus, screenStatus, postFeed, ageFilter, postSearch, error];

  DiscoverScreenState copyWith({
    DiscoverFeedStatus? feedStatus,
    DiscoverScreenStatus? screenStatus,
    List<Post>? postFeed,
    List<Post>? postSearch,
    DiscoverScreenError? error,
    DiscoverAgeFilterState? ageFilter,
    PostRepository? postRepository,
  }) {
    return DiscoverScreenState(
      feedStatus: feedStatus ?? this.feedStatus,
      screenStatus: screenStatus ?? this.screenStatus,
      postFeed: postFeed ?? this.postFeed,
      postSearch: postSearch ?? this.postSearch,
      error: error ?? this.error,
      ageFilter: ageFilter ?? this.ageFilter,
      postRepository: postRepository ?? this.postRepository,
    );
  }
}
