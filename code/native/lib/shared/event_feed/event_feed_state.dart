part of "event_feed_bloc.dart";

enum EventFeedStatus { loading, success, failure }

class EventFeedState extends Equatable {
  const EventFeedState({
    this.status = EventFeedStatus.loading,
    this.events = const <Event>[],
    this.error = "",
  });

  final EventFeedStatus status;
  final List<Event> events;
  final String error;

  @override
  List<Object> get props => [status, events, error];

  EventFeedState copyWith({
    EventFeedStatus? status,
    List<Event>? events,
    String? error,
  }) {
    return EventFeedState(
      status: status ?? this.status,
      events: events ?? this.events,
      error: error ?? this.error,
    );
  }
}
