import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/home/application/home_drawer_bloc/home_drawer_bloc_bloc.dart';
import 'package:local/shared/presentation/black_button.dart';
import 'package:local/features/locale/presentation/locale_selector.dart';

GlobalKey homeLocaleSelectorKey = GlobalKey();

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDrawerBlocBloc, HomeDrawerBlocState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            // padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 4,
                color: Colors.black,
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // action row
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 32,
                  ),
                  child: _buildActionRow(),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: HomeDrawerFeed.values.map(
                    (e) {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SelectOption(
                            feed: e,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Row _buildActionRow() {
    return Row(
      children: [
        // local
        LocaleSelector(
          key: homeLocaleSelectorKey,
        ),
        const Spacer(),
        // close button
        BlackButton(
          icon: Icons.close,
          click: (context) {
            Scaffold.of(context).closeDrawer();
          },
        ),
      ],
    );
  }
}

class SelectOption extends StatelessWidget {
  SelectOption({
    super.key,
    required this.feed,
  });

  final HomeDrawerFeed feed;

  final Color activeColor = Colors.blue.shade600;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeDrawerBlocBloc, HomeDrawerBlocState>(
      builder: (context, state) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.lightImpact();
            context
                .read<HomeDrawerBlocBloc>()
                .add(ChangeFeed(drawerFeed: feed));
            Scaffold.of(context).closeDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: Row(
              children: [
                // active?
                Container(
                  width: 6,
                  height: 32,
                  decoration: BoxDecoration(
                    color: state.drawerFeed == feed
                        ? activeColor
                        : Colors.transparent,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                Icon(
                  feed.icon,
                  color: state.drawerFeed == feed ? activeColor : Colors.black,
                ),
                // icon
                const Padding(
                  padding: EdgeInsets.all(8),
                ),
                // text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feed.display,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: state.drawerFeed == feed
                                  ? activeColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        feed.description,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
                Icon(
                  state.drawerFeed == feed
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: state.drawerFeed == feed ? activeColor : Colors.black,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
