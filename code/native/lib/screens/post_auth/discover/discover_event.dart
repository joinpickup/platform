part of 'discover_bloc.dart';

abstract class DiscoverScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BeginSearch extends DiscoverScreenEvent {}

class ResetScreen extends DiscoverScreenEvent {}

class HandleSearch extends DiscoverScreenEvent {
  final String query;

  HandleSearch(this.query);
}

class HandleLoadMore extends DiscoverScreenEvent {
  final RefreshController refreshController;

  HandleLoadMore(this.refreshController);
}

class HandleRefresh extends DiscoverScreenEvent {
  final RefreshController refreshController;

  HandleRefresh(this.refreshController);
}

class LoadPosts extends DiscoverScreenEvent {}

class FilterPostsByAge extends DiscoverScreenEvent {
  final int start;
  final int end;

  FilterPostsByAge(this.start, this.end);
}

class ResetAgeFilterForPosts extends DiscoverScreenEvent {}

class FilterPostsByLocation extends DiscoverScreenEvent {
  final int start;
  final int end;

  FilterPostsByLocation(this.start, this.end);
}

class ResetLocationFilterForPosts extends DiscoverScreenEvent {}

class SortPosts extends DiscoverScreenEvent {
  final SortOption sort;

  SortPosts(this.sort);
}

class ResetSortForPosts extends DiscoverScreenEvent {}

class ResetAllFilters extends DiscoverScreenEvent {}
