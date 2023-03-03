import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/event.dart';
import 'package:local/models/event.dart';
import 'package:local/screens/post_auth/core/events_screen/event_card.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum EventFilter { upcoming, organized, saved, premium }

class EventFeed extends HookWidget {
  EventFeed({super.key, required this.filter});

  final EventFilter filter;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh(ValueNotifier<List<Event>> events) async {
    await Future.delayed(const Duration(milliseconds: 500));
    events.value = [...events.value];
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final events = useState([
      climbingSession1,
      climbingSession2,
    ]);

    return Expanded(
      child: SmartRefresher(
        onRefresh: () => _onRefresh(events),
        onLoading: () => _onLoading(),
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        child: ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
            return EventCard(
              event: events.value[index],
            );
          },
          shrinkWrap: true,
          itemCount: events.value.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
        ),
      ),
    );
  }
}
