part of 'discover_bloc.dart';

abstract class DiscoverScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BeginSearch extends DiscoverScreenEvent {}

class ResetSearch extends DiscoverScreenEvent {}

class HandleSearch extends DiscoverScreenEvent {
  final String query;

  HandleSearch(this.query);
}

class LoadPosts extends DiscoverScreenEvent {}
