import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local/components/icon_button.dart';
import 'package:local/theme/color.dart';
import 'package:local/theme/svg.dart';
import 'package:local/views/messages/messages_screen.dart';
import 'package:local/views/notifications/notifications_screen.dart';
import 'package:local/views/profile/profile_screen.dart';
import 'package:local/views/search/search_screen.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SearchBar(),
        const SizedBox(
          width: 8,
        ),
        CustomIconButton(
          icon: kIconMessage,
          click: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MessagesScreen(),
              ),
            );
          },
        ),
        const SizedBox(
          width: 8,
        ),
        CustomIconButton(
          click: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const NotificationsScreen(),
              ),
            );
          },
          icon: kIconNotifications,
        ),
        const SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () => {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            )
          },
          child: Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              border: Border.all(
                width: 3,
                color: kColorRoyal,
              ),
              color: Colors.red.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
            ),
            child: const Center(
              child: Text(
                "AC",
                style: TextStyle(
                  color: kColorRoyal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => (Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        ))),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(48),
            ),
            color: Color(0xFFEDD3B8),
          ),
          child: Row(
            children: [
              SvgPicture.string(
                kIconSearch,
                width: 24,
                height: 24,
                theme: const SvgTheme(
                  currentColor: kColorRoyal,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                "Search for a board...",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: kColorRoyal,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}