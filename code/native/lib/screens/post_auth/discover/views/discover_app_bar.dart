import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/components/input/input.dart';
import 'package:local/screens/post_auth/add_post/add_post_screen.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class DiscoverAppBar extends StatefulWidget {
  const DiscoverAppBar({
    super.key,
  });

  @override
  State<DiscoverAppBar> createState() => _DiscoverAppBarState();
}

class _DiscoverAppBarState extends State<DiscoverAppBar> {
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    searchFocus.addListener(() {
      if (searchFocus.hasFocus) {
        context.read<DiscoverScreenBloc>().add(BeginSearch());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscoverScreenBloc, DiscoverScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
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
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: CustomInput(
                    placeholder: "Search for a post...",
                    focus: searchFocus,
                    controller: searchController,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                state.screenStatus == DiscoverScreenStatus.searching
                    ? GestureDetector(
                        onTap: () async {
                          searchController.clear();
                          context.read<DiscoverScreenBloc>().add(ResetSearch());
                          FocusScope.of(context).unfocus();
                        },
                        child: const Text("Cancel"),
                      )
                    : Expanded(
                        flex: 0,
                        child: CustomIconButton(
                          size: 24,
                          icon: HeroIcons.plus,
                          tap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddPostScreen(),
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
