import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

extension ExtendedWidgetList on List<Widget> {
  /// Insert [widget] between each member of this list
  List<Widget> insertBetween(Widget widget) {
    if (length > 1) {
      for (var i = length - 1; i > 0; i--) {
        insert(i, widget);
      }
    }

    return this;
  }
}

class SettingsGroup extends StatefulWidget {
  const SettingsGroup({
    super.key,
    required this.name,
    required this.settings,
    this.includeName = false,
  });

  final String name;
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
              borderRadius: BorderRadius.circular(8),
              color: TW3Colors.gray.shade700,
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
