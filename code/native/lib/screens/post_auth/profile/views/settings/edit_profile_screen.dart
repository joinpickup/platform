import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class EditProfileScreen extends HookWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
    );
  }
}
