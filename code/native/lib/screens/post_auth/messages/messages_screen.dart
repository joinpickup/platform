import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/message/thread.dart';
import 'package:local/screens/post_auth/messages/chat_screen.dart';
import 'package:local/screens/post_auth/messages/views/chat_thread_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

List<Thread> current = [
  Thread(
    threadID: 1,
    createdAt: DateTime.now(),
    lastMessage: messages.last,
    person1: andrew,
    person2: brian,
    isRead: false,
    isRequest: false,
  ),
];

List<Thread> requests = [
  Thread(
    threadID: 2,
    createdAt: DateTime.now(),
    lastMessage: messages.last,
    person1: andrew,
    person2: stef,
    isRead: true,
    isRequest: true,
  ),
];

List<Thread> hidden = [
  Thread(
    threadID: 3,
    createdAt: DateTime.now(),
    lastMessage: messages.last,
    person1: andrew,
    person2: jay,
    isRead: true,
    isRequest: false,
  ),
];

List<List<Thread>> listsOfThreads = [current, requests, hidden];

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TabBarBloc(),
        ),
      ],
      child: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, tabBarState) {
          return Scaffold(
            backgroundColor: TW3Colors.gray.shade700,
            appBar: AppBar(
              backgroundColor: TW3Colors.gray.shade700,
              elevation: 0,
              title: const Text("Messages"),
            ),
            body: Column(
              children: [
                _buildTabBar(),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ChatThreadFeed(
                    threads: listsOfThreads[tabBarState.tab],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  CustomTabBar _buildTabBar() {
    return CustomTabBar(
      small: true,
      tabs: [
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Current",
          tab: 0,
          small: true,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Requests",
          tab: 1,
          small: true,
        ),
        CustomTab(
          activeColor: TW3Colors.gray.shade600,
          label: "Hidden",
          tab: 2,
          small: true,
        ),
      ],
    );
  }
}
