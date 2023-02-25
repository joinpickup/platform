import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/navigator/pre_auth/pre_auth_navigator.dart';
import 'package:local/theme/dark_mode.dart';

import 'navigator/post_auth/post_auth_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = useState(true);
    return MaterialApp(
      home: user.value ? const PostAuthNavigator() : const PreAuthNavigator(),
      theme: darkTheme,
    );
  }
}
