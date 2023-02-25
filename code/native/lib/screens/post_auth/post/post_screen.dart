import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostScreen extends HookWidget {
  const PostScreen({super.key, required this.postID});

  final int postID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.blue,
          child: Text("Post ID $postID"),
        ),
      ),
    );
  }
}
