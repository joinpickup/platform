import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:local/components/badge.dart';
import 'package:local/models/person.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EventParticipantPage extends HookWidget {
  const EventParticipantPage({super.key, required this.participants});

  final List<Person> participants;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: participants.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Participant(
                  participant: participants[index],
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class Participant extends HookWidget {
  const Participant({super.key, required this.participant});

  final Person participant;

  @override
  Widget build(BuildContext context) {
    final opacity = useState(1.0);

    return GestureDetector(
      onTapDown: (details) {
        opacity.value = 0.6;
      },
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) =>
                PersonScreen(personID: participant.personID),
          ),
        );
      },
      onTapUp: (details) {
        opacity.value = 1;
      },
      onTapCancel: () {
        opacity.value = 1;
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: opacity.value,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: TW3Colors.gray.shade700,
            border: Border.all(
              color: TW3Colors.gray.shade500.withOpacity(.25),
              width: 2.0,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.blue.shade400,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      participant.name,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      participant.username,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
              const CustomBadge(
                text: "Organizer",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
