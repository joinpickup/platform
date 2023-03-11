import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/person.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/events/views/event_feed.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({
    super.key,
    required this.personID,
  });

  final int personID;

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  Person? person;

  @override
  void initState() {
    super.initState();

    person = allPersons.firstWhere(
      (person) => person.personID == widget.personID,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: PostFeedBloc()..add(LoadPosts()),
        ),
        BlocProvider.value(
          value: EventFeedBloc()..add(LoadEvents()),
        ),
        BlocProvider<TabBarBloc>.value(
          value: TabBarBloc()..add(InitializeTabBar()),
        ),
      ],
      child: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, state) {
          return _buildPage(context, state);
        },
      ),
    );
  }

  Scaffold _buildPage(BuildContext context, TabBarState state) {
    return Scaffold(
      backgroundColor: TW3Colors.gray.shade600,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: TW3Colors.gray.shade700,
              title: const Text("View Person"),
              pinned: true,
              elevation: 0,
              expandedHeight: 378,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildPersonInfo(person as Person, context),
                    _buildPersonActions(person as Person, context),
                    CustomTabBar(
                      tabs: [
                        CustomTab(
                          activeColor: TW3Colors.gray.shade600,
                          label: "Posts",
                          tab: 0,
                        ),
                        CustomTab(
                          activeColor: TW3Colors.gray.shade600,
                          label: "Events",
                          tab: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                  ),
                )
              ],
            ),
          ];
        },
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPersonFeed(person as Person, state.tab, context),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonInfo(Person person, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: TW3Colors.gray.shade700,
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.blue.shade400,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                person.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                "(${person.username})",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          DetailRow(icon: HeroIcons.map, text: person.location.commonName),
          const SizedBox(
            height: 8,
          ),
          const DetailRow(icon: HeroIcons.eye, text: "Public"),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    super.key,
    required this.icon,
    required this.text,
  });

  final HeroIcons icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade600,
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: HeroIcon(
            icon,
            style: HeroIconStyle.solid,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            text,
          ),
        ),
      ],
    );
  }
}

Widget _buildPersonActions(Person person, BuildContext context) {
  return Container(
    decoration: BoxDecoration(color: TW3Colors.gray.shade700),
    padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        CustomButton(
          text: "Add Friend",
          tap: () {},
        )
      ],
    ),
  );
}

Widget _buildPersonFeed(
  Person person,
  int tab,
  BuildContext context,
) {
  switch (tab) {
    case 0:
      return PostFeed();
    case 1:
      return const EventFeed();
    default:
      return Container();
  }
}
