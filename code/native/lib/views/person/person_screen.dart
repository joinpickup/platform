import 'package:flutter/material.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Person",
        ),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16.0,
            16.0,
            16.0,
            0.0,
          ),
          child: Text("This is a test"),
        ),
      ),
    );
  }
}
