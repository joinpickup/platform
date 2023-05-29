import 'package:flutter/material.dart';
import 'package:local/main.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SettingsGroup extends StatefulWidget {
  const SettingsGroup({
    super.key,
    required this.name,
    required this.settings,
    this.color = Colors.transparent,
    this.includeName = false,
  });

  final String name;
  final Color color;
  final bool includeName;
  final List<Widget> settings;

  @override
  State<SettingsGroup> createState() => _SettingsGroupState();
}

class _SettingsGroupState extends State<SettingsGroup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.includeName
              ? Column(
                  children: [
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox.fromSize(
                      size: const Size.fromHeight(8),
                    ),
                  ],
                )
              : Container(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.color,
              border: Border.all(
                color: TW3Colors.gray.shade500.withOpacity(.25),
                width: 2.0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.settings.insertBetween(
                const SizedBox(
                  height: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
