import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/components/input/button.dart';
import 'package:local/components/navigation/tab_bar.dart';
import 'package:local/mocks/person.dart';
import 'package:local/models/person.dart';
import 'package:local/screens/post_auth/core/discover_screen/presentation/post_feed.dart';
import 'package:local/screens/post_auth/core/events_screen/event_feed.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class PersonScreen extends HookWidget {
  const PersonScreen({super.key, required this.personID});

  final int personID;

  @override
  Widget build(BuildContext context) {
    final tab = useState(0);
    final person = useState(
        allPersons.firstWhere((person) => person.personID == personID));

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
          _buildPersonInfo(person.value, context),
          _buildPersonActions(person.value, context),
          CustomTabBar(
            tab: tab,
            tabs: [
              CustomTabModel(
                activeColor: TW3Colors.gray.shade600,
                label: "Posts",
                tab: 0,
              ),
              CustomTabModel(
                activeColor: TW3Colors.gray.shade600,
                label: "Events",
                tab: 1,
              ),
            ],
          ),
          _buildPersonFeed(person.value, tab, context),
        ],
      ),
    );
  }
}

Widget _buildPersonInfo(Person person, BuildContext context) {
  return Container(
    decoration: BoxDecoration(color: TW3Colors.gray.shade700),
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

class DetailRow extends HookWidget {
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
  ValueNotifier<int> tab,
  BuildContext context,
) {
  switch (tab.value) {
    case 0:
      return PostFeed();
    case 1:
      return EventFeed(
        filter: EventFilter.upcoming,
      );
    default:
      return Container();
  }
}
