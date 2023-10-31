import 'package:flutter/material.dart';

class HomeEndDrawer extends StatelessWidget {
  const HomeEndDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            width: 4,
            color: Colors.black,
          ),
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
