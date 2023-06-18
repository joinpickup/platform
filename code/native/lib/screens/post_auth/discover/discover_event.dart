part of 'discover_bloc.dart';

abstract class DiscoverScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BeginSearch extends DiscoverScreenEvent {}

class ResetScreen extends DiscoverScreenEvent {
  final String query;

  // filters
  final List<Interest> interests;
  final List<Space> spaces;

  ResetScreen({
    required this.query,
    required this.interests,
    required this.spaces,
  });
}

class SearchPosts extends DiscoverScreenEvent {
  final String query;

  // filters
  final List<Interest> interests;
  final List<Space> spaces;

  SearchPosts({
    required this.query,
    required this.interests,
    required this.spaces,
  });
}

class HandleLoadMore extends DiscoverScreenEvent {
  final RefreshController refreshController;
  final String query;

  // filters
  final List<Interest> interests;
  final List<Space> spaces;

  HandleLoadMore({
    required this.refreshController,
    required this.query,
    required this.interests,
    required this.spaces,
  });
}

class HandleRefresh extends DiscoverScreenEvent {
  final RefreshController refreshController;
  final String query;

  // filters
  final List<Interest> interests;
  final List<Space> spaces;

  HandleRefresh({
    required this.refreshController,
    required this.query,
    required this.interests,
    required this.spaces,
  });
}

class LoadPosts extends DiscoverScreenEvent {
  final String query;

  // filters
  final List<Interest> interests;
  final List<Space> spaces;

  LoadPosts({
    required this.query,
    required this.interests,
    required this.spaces,
  });
}

class FilterPosts extends DiscoverScreenEvent {
  final List<Interest> interests;
  final List<Space> spaces;

  FilterPosts({
    required this.interests,
    required this.spaces,
  });
}
