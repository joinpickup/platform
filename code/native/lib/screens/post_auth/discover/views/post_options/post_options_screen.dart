import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showPostOptionsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (context) {
      return const PostOptionsModal();
    },
  );
}

class PostOptionsModal extends StatelessWidget {
  const PostOptionsModal({
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
                width: 100,
                height: 4,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SettingsGroup(
              name: "Post Settings",
              settings: [
                SettingsItem(
                  icon: HeroIcons.share,
                  name: "Share Post",
                  action: () {
                    Share.share("Check out this post...");
                  },
                ),
                SettingsItem(
                  icon: HeroIcons.eyeSlash,
                  name: "Hide Post",
                  action: () {},
                ),
                SettingsItem(
                  icon: HeroIcons.user,
                  name: "Block User",
                  action: () {},
                ),
                SettingsItem(
                  icon: HeroIcons.flag,
                  name: "Report",
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
