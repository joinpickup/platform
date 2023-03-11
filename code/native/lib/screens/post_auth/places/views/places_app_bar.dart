import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/input/input.dart';
import 'package:local/screens/post_auth/add_place/add_place.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PlacesAppBar extends StatefulWidget {
  const PlacesAppBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  State<PlacesAppBar> createState() => _PlacesAppBarState();
}

class _PlacesAppBarState extends State<PlacesAppBar> {
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
              placeholder: "Search for a place...",
              controller: widget.searchController,
            ),
          ),
          Expanded(
            flex: 0,
            child: CustomIconButton(
              size: 24,
              icon: HeroIcons.plus,
              tap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddPlaceScreen(),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
