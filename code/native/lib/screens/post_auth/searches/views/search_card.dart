import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/icon_button.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/screens/post_auth/searches/views/options/search_options.dart';
import 'package:local/screens/post_auth/searches/views/search_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class SearchCard extends StatefulWidget {
  const SearchCard({
    super.key,
    required this.search,
  });

  final Search search;

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  double opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          opacity = 0.6;
        });
      },
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SearchScreen(
              search: widget.search,
            );
          },
        ));
      },
      onTapUp: (details) {
        setState(() {
          opacity = 1;
        });
      },
      onTapCancel: () {
        setState(() {
          opacity = 1;
        });
      },
      onLongPress: () {
        HapticFeedback.heavyImpact();
        showSearchOptionsModal(
          context,
          widget.search,
        );
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: TW3Colors.gray.shade600,
            ),
            borderRadius: BorderRadius.circular(8),
            color: TW3Colors.gray.shade700,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.search.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  CustomIconButton(
                    tap: () {
                      showSearchOptionsModal(
                        context,
                        widget.search,
                      );
                    },
                    child: const HeroIcon(
                      HeroIcons.ellipsisVertical,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    widget.search.description,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: TW3Colors.gray.shade400,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Matches ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: TW3Colors.gray.shade400,
                          ),
                      children: [
                        TextSpan(
                          text: "${widget.search.posts.length}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        TextSpan(
                          text:
                              " post${widget.search.posts.length == 1 ? "" : "s"}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
