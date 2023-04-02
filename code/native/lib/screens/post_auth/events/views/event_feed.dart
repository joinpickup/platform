import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/skelaton/event_card_skelaton.dart';
import 'package:local/screens/post_auth/events/views/event_card.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum EventFilter { upcoming, organized, saved, premium }

class EventFeed extends StatefulWidget {
  const EventFeed({super.key});

  @override
  State<EventFeed> createState() => _EventFeedState();
}

class _EventFeedState extends State<EventFeed> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFeedBloc, EventFeedState>(
      builder: (context, state) {
        switch (state.status) {
          case EventFeedStatus.success:
            return Expanded(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () => context
                    .read<EventFeedBloc>()
                    .add(RefreshEvents(refreshController: _refreshController)),
                onLoading: () => context
                    .read<EventFeedBloc>()
                    .add(LoadEvents(refreshController: _refreshController)),
                controller: _refreshController,
                child: ListView.separated(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemBuilder: (BuildContext context, int index) {
                    return EventCard(
                      event: state.events[index],
                    );
                  },
                  shrinkWrap: true,
                  itemCount: state.events.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                ),
              ),
            );
          case EventFeedStatus.loading:
            return const EventCardSkelaton();
          default:
            return Container();
        }
      },
    );
  }
}
