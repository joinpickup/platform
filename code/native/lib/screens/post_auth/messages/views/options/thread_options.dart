import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showThreadOptionsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const ThreadOptionsModal();
    },
  );
}

class ThreadOptionsModal extends StatelessWidget {
  const ThreadOptionsModal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: TW3Colors.gray.shade500,
                ),
                width: 64,
                height: 4,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SettingsGroup(
              name: "Thread Settings",
              settings: [
                SettingsItem(
                  icon: HeroIcons.eyeSlash,
                  name: "Hide Thread",
                  action: () {},
                ),
                SettingsItem(
                  icon: HeroIcons.user,
                  name: "Block User",
                  action: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
