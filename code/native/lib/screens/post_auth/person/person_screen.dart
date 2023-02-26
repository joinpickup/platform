import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PersonScreen extends HookWidget {
  const PersonScreen({super.key, required this.personID});

  final int personID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Person Screen $personID",
        ),
      ),
    );
  }
}
