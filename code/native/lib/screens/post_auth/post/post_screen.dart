import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PostScreen extends HookWidget {
  const PostScreen({super.key, required this.postID});

  final int postID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Page $postID")),
      body: Container(),
    );
  }
}
