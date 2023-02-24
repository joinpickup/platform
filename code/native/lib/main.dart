import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/navigator/pre_auth_navigator.dart';

import 'navigator/post_auth/post_auth_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = useState(true);

    if (user.value) {
      return const CupertinoApp(home: PostAuthNavigator());
    } else {
      return const CupertinoApp(home: PreAuthNavigator());
    }
  }
}
