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
  final bool enabled;
  final int start;
  final int end;

  const DiscoverAgeFilterState({
    required this.enabled,
    this.start = kAgeFilterStart,
    this.end = kAgeFilterEnd,
  });

  @override
  List<Object?> get props => [enabled, start, end];
}

class DiscoverSpaceFilterState extends Equatable {
  final bool enabled;
  final Space? space;

  const DiscoverSpaceFilterState({
    required this.enabled,
    this.space,
  });

  @override
  List<Object?> get props => [enabled, space];
}

class DiscoverLocationFilterState extends Equatable {
  final bool enabled;
  final int start;
  final int end;

  const DiscoverLocationFilterState({
    required this.enabled,
    this.start = kLocationFilterStart,
    this.end = kLocationFilterEnd,
  });

  @override
  List<Object?> get props => [enabled, start, end];
}

class DiscoverSortState extends Equatable {
  final bool enabled;
  final SortOption sort;

  const DiscoverSortState({
    required this.enabled,
    this.sort = kSort,
  });

  @override
  List<Object?> get props => [enabled, sort];
}

class DiscoverScreenState extends Equatable {
  final DiscoverFeedStatus feedStatus;
  final DiscoverScreenStatus screenStatus;
  final List<Post>? postFeed;
  final List<Post>? postSearch;
  final DiscoverScreenError? error;

  // filters and sort
  final DiscoverSpaceFilterState spaceFilter;
  final DiscoverAgeFilterState ageFilter;
  final DiscoverLocationFilterState locationFilter;
  final DiscoverSortState sortState;

  final PostRepository postRepository;

  const DiscoverScreenState({
    this.feedStatus = DiscoverFeedStatus.loading,
    this.screenStatus = DiscoverScreenStatus.init,
    this.postFeed,
    this.postSearch,
    this.error,
    this.ageFilter = const DiscoverAgeFilterState(enabled: false),
    this.locationFilter = const DiscoverLocationFilterState(enabled: false),
    this.sortState = const DiscoverSortState(enabled: false),
    this.spaceFilter = const DiscoverSpaceFilterState(enabled: false),
    required this.postRepository,
  });

  @override
  List<Object?> get props => [
        feedStatus,
        screenStatus,
        postFeed,
        error,

        // filters
        spaceFilter,
        ageFilter,
        locationFilter,
        sortState,

        // search
        postSearch,
      ];

  DiscoverScreenState copyWith({
    DiscoverFeedStatus? feedStatus,
    DiscoverScreenStatus? screenStatus,
    List<Post>? postFeed,
    List<Post>? postSearch,
    DiscoverScreenError? error,
    DiscoverSpaceFilterState? spaceFilter,
    DiscoverAgeFilterState? ageFilter,
    DiscoverLocationFilterState? locationFilter,
    DiscoverSortState? sortState,
    PostRepository? postRepository,
  }) {
    return DiscoverScreenState(
      feedStatus: feedStatus ?? this.feedStatus,
      screenStatus: screenStatus ?? this.screenStatus,
      postFeed: postFeed ?? this.postFeed,
      postSearch: postSearch ?? this.postSearch,
      error: error ?? this.error,
      spaceFilter: spaceFilter ?? this.spaceFilter,
      ageFilter: ageFilter ?? this.ageFilter,
      locationFilter: locationFilter ?? this.locationFilter,
      sortState: sortState ?? this.sortState,
      postRepository: postRepository ?? this.postRepository,
    );
  }
}
