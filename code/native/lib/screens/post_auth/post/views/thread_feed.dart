import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ThreadFeed extends StatefulWidget {
  const ThreadFeed({super.key, required this.postID});

  final int postID;

  @override
  State<ThreadFeed> createState() => _ThreadFeedState();
}

class _ThreadFeedState extends State<ThreadFeed> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(),
    );
  }
}
