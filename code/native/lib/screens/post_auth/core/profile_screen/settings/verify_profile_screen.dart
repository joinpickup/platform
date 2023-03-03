import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class VerifyProfileScreen extends HookWidget {
  const VerifyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Profile Screen"),
      ),
    );
  }
}
