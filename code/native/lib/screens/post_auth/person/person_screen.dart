import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar/custom_tab.dart';
import 'package:local/components/navigation/tab_bar/tab_bar.dart';
import 'package:local/components/navigation/tab_bar/tab_bar_bloc.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/repos/post_repository.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/events/views/event_feed.dart';
import 'package:local/shared/event_feed/event_feed_bloc.dart';
import 'package:local/shared/post_feed/post_feed_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
        BlocProvider(
          create: (context) => PostFeedBloc(
            context.read<AddPostBloc>().state.postRepository,
          )..add(LoadPostsPost()),
        ),
        BlocProvider(
          create: (context) => EventFeedBloc()..add(LoadEvents()),
        ),
        BlocProvider(
          create: (context) => TabBarBloc()..add(InitializeTabBar()),
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
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Person"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          )
        ],
      ),
      backgroundColor: TW3Colors.gray.shade700,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPersonInfo(person as Person, context),
        ],
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
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(36),
              child: Image.asset(person.avatar, fit: BoxFit.cover),
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

Widget _buildPersonFeed(
  Person person,
  int tab,
  BuildContext context,
) {
  switch (tab) {
    case 0:
      return PostFeed(
        scrollController: ScrollController(),
        canLoad: false,
        canRefresh: false,
        refreshController: RefreshController(),
        posts: const [],
      );
    default:
      return Container();
  }
}
