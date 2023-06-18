part of 'searches_screen_bloc.dart';

enum SearchType { recommended, saved, more }

enum SearchStatus { loading, error, success }

class SearchesScreenState extends Equatable {
  final List<Search> searches;
  final SearchStatus status;
  final SearchRepository searchRepository;

  const SearchesScreenState({
    this.searches = const [],
    this.status = SearchStatus.loading,
    required this.searchRepository,
  });

  @override
  List<Object?> get props => [searches];

  SearchesScreenState copyWith({
    List<Search>? searches,
    SearchStatus? status,
    SearchRepository? searchRepository,
  }) {
    return SearchesScreenState(
      searches: searches ?? this.searches,
      status: status ?? this.status,
      searchRepository: searchRepository ?? this.searchRepository,
    );
  }
}
