part of 'interest_filter_modal_bloc.dart';

abstract class InterestFilterModalEvent extends Equatable {}

class LoadInterests extends InterestFilterModalEvent {
  final List<Interest> selected;

  LoadInterests({
    this.selected = const [],
  });

  @override
  List<Object?> get props => [];
}

class SaveInterests extends InterestFilterModalEvent {
  SaveInterests({
    required this.interests,
  });

  final List<Interest> interests;

  @override
  List<Object?> get props => [];
}

class SearchIntersts extends InterestFilterModalEvent {
  SearchIntersts({
    required this.query,
  });

  final String query;

  @override
  List<Object?> get props => [];
}

class ResetInterestSearch extends InterestFilterModalEvent {
  @override
  List<Object?> get props => [];
}

class ClearInterests extends InterestFilterModalEvent {
  @override
  List<Object?> get props => [];
}
