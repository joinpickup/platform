import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupDrawerAppBar extends HookWidget {
  const GroupDrawerAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: TW3Colors.blue.shade400,
    );
  }
}
