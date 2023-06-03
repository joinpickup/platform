import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showChatOptionsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const ChatOptionsModal();
    },
  );
}

class ChatOptionsModal extends StatelessWidget {
  const ChatOptionsModal({
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
              name: "Message Settings",
              settings: [
                SettingsItem(
                  icon: HeroIcons.documentDuplicate,
                  name: "Copy Message",
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
