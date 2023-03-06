import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddEventScreen extends HookWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Event",
        ),
      ),
    );
  }
}