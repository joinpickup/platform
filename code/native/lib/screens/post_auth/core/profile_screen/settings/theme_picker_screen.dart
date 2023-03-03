import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ThemePickerScreen extends HookWidget {
  const ThemePickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select App Theme"),
      ),
    );
  }
}
