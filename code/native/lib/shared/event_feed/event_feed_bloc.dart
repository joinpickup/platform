import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/repos/data/mocks/event.dart';
import 'package:local/repos/data/models/event.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'event_feed_event.dart';
part 'event_feed_state.dart';

class EventFeedBloc extends Bloc<EventFeedEvent, EventFeedState> {
  EventFeedBloc() : super(const EventFeedState()) {
    on<LoadEvents>(_onLoadEvents);
    on<RefreshEvents>(_onRefreshEvents);
  }

  Future<void> _onLoadEvents(
    LoadEvents event,
    Emitter<EventFeedState> emit,
  ) async {
    await Future.delayed(const Duration(milliseconds: 250));
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
}
