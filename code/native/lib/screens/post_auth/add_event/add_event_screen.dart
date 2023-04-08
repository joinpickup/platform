import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade700,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text(
          "Add Event",
        ),
      ),
      body: _buildBody(),
    );
  }

  SafeArea _buildBody() {
    return SafeArea(
      child: Column(),
    );
  }
}
