part of 'searches_screen_bloc.dart';

abstract class SearchesScreenEvent extends Equatable {}

class LoadSearches extends SearchesScreenEvent {
  final SearchType type;

  LoadSearches({
    this.type = SearchType.recommended,
  });

  @override
  List<Object?> get props => [];
}

class CreateSearch extends SearchesScreenEvent {
  final Search search;

  CreateSearch({
    required this.search,
  });

  @override
  List<Object?> get props => [];
}

class EditSearch extends SearchesScreenEvent {
  final Search search;

  EditSearch({
    required this.search,
  });

  @override
  List<Object?> get props => [];
}

class DisableNotifications extends SearchesScreenEvent {
  final Search search;

  DisableNotifications({
    required this.search,
  });

  @override
  List<Object?> get props => [];
}

class MakePublic extends SearchesScreenEvent {
  final Search search;

  MakePublic({
    required this.search,
  });

  @override
  List<Object?> get props => [];
}

class RemoveSearch extends SearchesScreenEvent {
  final Search search;

  RemoveSearch({
    required this.search,
  });

  @override
  List<Object?> get props => [];
}
