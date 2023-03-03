import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/edit_profile_screen.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/setting_item.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/settings_group.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/theme_picker_screen.dart';
import 'package:local/screens/post_auth/core/profile_screen/settings/verify_profile_screen.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class GroupSettings extends HookWidget {
  const GroupSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            _buildProfileSettings(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildProfileSettings(BuildContext context) {
  return Column(
    children: [
      SettingsGroup(
        includeName: false,
        name: "Account Settings",
        settings: [
          SettingsItem(
            icon: HeroIcons.check,
            name: "Verify Account",
            action: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const VerifyProfileScreen(),
              ));
            },
            hasArrow: true,
          ),
          SettingsItem(
            icon: HeroIcons.user,
            name: "Edit Profile",
            action: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
            hasArrow: true,
          ),
          SettingsItem(
            icon: HeroIcons.arrowLeftOnRectangle,
            name: "Logout",
            action: () {},
            hasArrow: false,
          ),
        ],
      ),
      SizedBox.fromSize(
        size: const Size.fromHeight(8),
      ),
      SettingsGroup(
        includeName: false,
        name: "Application Settings",
        settings: [
          SettingsItem(
            hasArrow: true,
            icon: HeroIcons.swatch,
            name: "Theme",
            action: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ThemePickerScreen(),
              ));
            },
          ),
        ],
      ),
    ],
  );
}
