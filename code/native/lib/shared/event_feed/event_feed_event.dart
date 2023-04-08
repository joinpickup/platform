part of 'event_feed_bloc.dart';

abstract class EventFeedEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RefreshEvents extends EventFeedEvent {
  RefreshEvents({required this.refreshController});

  final RefreshController refreshController;
}

class LoadEvents extends EventFeedEvent {
  LoadEvents({this.refreshController});

  final RefreshController? refreshController;
}

class FilterEvents extends EventFeedEvent {
  FilterEvents({required this.filter});

  final EventFilter filter;
}
