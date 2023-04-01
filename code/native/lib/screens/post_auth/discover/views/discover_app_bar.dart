import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/screens/post_auth/discover/discover_bloc.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_screen.dart';
import 'package:local/screens/post_auth/discover/views/discover_filter_bar.dart';
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
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                DiscoverSearchBar(
                    searchController: searchController,
                    searchFocus: searchFocus,
                    state: state),
                const SizedBox(
                  height: 8,
                ),
                const DiscoverFilterBar(),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class DiscoverSearchBar extends StatelessWidget {
  const DiscoverSearchBar({
    super.key,
    required this.searchController,
    required this.searchFocus,
    required this.state,
  });

  final TextEditingController searchController;
  final FocusNode searchFocus;
  final DiscoverScreenState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CupertinoTextField(
              padding: const EdgeInsets.all(8),
              controller: searchController,
              onChanged: (value) =>
                  {context.read<DiscoverScreenBloc>().add(HandleSearch(value))},
              onTap: () {
                context.read<DiscoverScreenBloc>().add(BeginSearch());
              },
              prefix: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: HeroIcon(
                  HeroIcons.magnifyingGlass,
                  size: 20,
                  color: TW3Colors.gray.shade300,
                ),
              ),
              placeholder: "Search for a post...",
              placeholderStyle: TextStyle(
                color: TW3Colors.gray.shade400,
                fontFamily: "Nunito",
              ),
              style: TextStyle(
                color: TW3Colors.gray.shade300,
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold,
              ),
              decoration: BoxDecoration(
                color: TW3Colors.gray.shade600,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          state.screenStatus == DiscoverScreenStatus.searching
              ? GestureDetector(
                  onTap: () async {
                    searchController.clear();
                    context.read<DiscoverScreenBloc>().add(ResetScreen());
                    FocusScope.of(context).unfocus();
                  },
                  child: const Text("Cancel"),
                )
              : Expanded(
                  flex: 0,
                  child: CustomIconButton(
                    tap: () {
                      showAddPostModal(
                        context,
                      );
                    },
                    child: const HeroIcon(HeroIcons.plus),
                  ),
                ),
        ],
      ),
    );
  }
}
