import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/screens/post_auth/discover/views/add_post/add_post_bloc.dart';
import 'package:local/screens/post_auth/discover/views/post_feed.dart';
import 'package:local/screens/post_auth/person/person_bloc.dart';
import 'package:local/screens/post_auth/person/views/person_options_screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PersonBloc(
            context.read<AddPostBloc>().state.personRepository,
          )..add(
              LoadPerson(
                personID: widget.personID,
              ),
            ),
        ),
      ],
      child: BlocBuilder<PersonBloc, PersonState>(
        builder: (context, state) {
          switch (state.status) {
            case PersonStatus.loading:
              return _buildLoading();
            case PersonStatus.error:
              return _buildError();
            case PersonStatus.success:
              return _buildSuccess(context, state.person as Person);
            default:
          }
          return Container();
        },
      ),
    );
  }

  Scaffold _buildLoading() {
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
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          width: double.maxFinite,
          height: 175,
          color: TW3Colors.gray.shade700,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                height: 20,
                decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.maxFinite,
                height: 100,
                decoration: BoxDecoration(
                  color: TW3Colors.gray.shade600,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Scaffold _buildError() {
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
          ),
        ],
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Center(
          child: Text(
            "Error loading person",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }

  Scaffold _buildSuccess(
    BuildContext context,
    Person person,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TW3Colors.gray.shade700,
        title: const Text("View Person"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showPersonOptionsModal(
                context,
              );
            },
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
          _buildPersonInfo(person, context),
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
