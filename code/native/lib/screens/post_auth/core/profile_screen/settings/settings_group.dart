import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/setting_item.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SettingsGroup extends HookWidget {
  const SettingsGroup({
    super.key,
    required this.name,
    required this.settings,
  });

  final String name;
  final List<SettingsItem> settings;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: TW3Colors.gray.shade500,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: settings,
            ),
          ),
        ],
      ),
    );
  }
}
