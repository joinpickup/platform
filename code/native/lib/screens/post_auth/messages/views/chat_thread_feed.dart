import 'package:flutter/material.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/message/thread.dart';
import 'package:local/screens/post_auth/messages/chat_screen.dart';
import 'package:local/screens/post_auth/messages/views/chat_thread.dart';

List<Thread> threads = [
  Thread(
    threadID: 1,
    createdAt: DateTime.now(),
    lastMessage: messages.last,
    person1: andrew,
    person2: brian,
    isRead: false,
  ),
];

class ChatThreadFeed extends StatefulWidget {
  const ChatThreadFeed({Key? key}) : super(key: key);

  @override
  State<ChatThreadFeed> createState() => _ChatThreadFeedState();
}

class _ChatThreadFeedState extends State<ChatThreadFeed> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: threads.length,
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemBuilder: (context, index) {
        return ChatThread(
          thread: threads[index],
        );
      },
      shrinkWrap: true,
    );
  }
}
