import 'package:flutter/material.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class Location extends StatelessWidget {
  const Location({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: TW3Colors.gray.shade700,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
