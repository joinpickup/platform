import 'package:flutter/material.dart';
import 'package:local/repos/data/models/message/thread.dart';
import 'package:local/screens/post_auth/messages/views/chat_thread.dart';

class ChatThreadFeed extends StatefulWidget {
  const ChatThreadFeed({
    Key? key,
    required this.threads,
  }) : super(key: key);

  final List<Thread> threads;

  @override
  State<ChatThreadFeed> createState() => _ChatThreadFeedState();
}

class _ChatThreadFeedState extends State<ChatThreadFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      child: ListView.separated(
        itemCount: widget.threads.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          return ChatThread(
            thread: widget.threads[index],
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
