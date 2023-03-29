import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/input/input.dart';
import 'package:local/screens/post_auth/add_event/add_event_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EventsAppBar extends StatelessWidget {
  const EventsAppBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border(
          bottom: BorderSide(
            color: TW3Colors.gray.shade500.withOpacity(.25),
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(children: [
          Expanded(
            flex: 1,
            child: CustomInput(
              placeholder: "Search for an event...",
              controller: searchController,
            ),
          ),
          Expanded(
            flex: 0,
            child: CustomIconButton(
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddEventScreen(),
                  ),
                );
              },
              child: const HeroIcon(HeroIcons.plus),
            ),
          ),
        ]),
      ),
    );
  }
}
