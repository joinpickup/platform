import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/mocks/person.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PersonScreen extends HookWidget {
  const PersonScreen({super.key, required this.personID});

  final int personID;

  @override
  Widget build(BuildContext context) {
    final person = useState(allPersons.firstWhere(
      (person) => person.personID == personID,
    ));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade600,
        title: const Text("View Profile"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          )
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: Container(),
    );
  }
}
