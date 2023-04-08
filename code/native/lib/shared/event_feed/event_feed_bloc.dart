import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/mocks/event.dart';
import 'package:local/repos/data/models/event/event.dart';
import 'package:local/screens/post_auth/events/views/event_feed.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'event_feed_event.dart';
part 'event_feed_state.dart';

class EventFeedBloc extends Bloc<EventFeedEvent, EventFeedState> {
  EventFeedBloc() : super(const EventFeedState()) {
    on<LoadEvents>(_onLoadEvents);
    on<RefreshEvents>(_onRefreshEvents);
    on<FilterEvents>(_onFilterEvents);
  }

  Future<void> _onLoadEvents(
    LoadEvents event,
    Emitter<EventFeedState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    final events = [...state.events, ...allEvents];
    emit(
      state.copyWith(
        events: events,
        status: EventFeedStatus.success,
      ),
    );

    event.refreshController?.loadComplete();
  }

  Future<void> _onRefreshEvents(
    RefreshEvents event,
    Emitter<EventFeedState> emit,
  ) async {
    final events = [...state.events];

    emit(
      state.copyWith(
        events: events,
        status: EventFeedStatus.success,
      ),
    );

    event.refreshController.refreshCompleted();
  }

  Future<void> _onFilterEvents(
    FilterEvents event,
    Emitter<EventFeedState> emit,
  ) async {
    emit(
      state.copyWith(
        events: [],
        status: EventFeedStatus.loading,
      ),
    );

    final events = [...state.events, ...allEvents];

    emit(
      state.copyWith(
        events: events,
        status: EventFeedStatus.success,
      ),
    );
  }
}
