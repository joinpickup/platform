import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/profile/views/settings/edit_profile/modals/change_avatar_modal.dart';
import 'package:local/screens/post_auth/profile/views/settings/edit_profile/modals/change_username_modal.dart';
import 'package:local/screens/post_auth/profile/views/settings/edit_profile/modals/edit_bio_modal.dart';
import 'package:local/screens/post_auth/profile/views/settings/edit_profile/modals/edit_name_modal.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        elevation: 0,
      ),
      backgroundColor: TW3Colors.gray.shade600,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              _buildProfileSettings(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildProfileSettings(BuildContext context) {
  return Column(
    children: [
      SettingsGroup(
        color: TW3Colors.gray.shade700,
        name: "Account Settings",
        settings: [
          SettingsItem(
            icon: HeroIcons.user,
            name: "Change Avatar",
            action: () {
              showChangeAvatarModal(
                context,
              );
            },
          ),
          SettingsItem(
            icon: HeroIcons.pencil,
            name: "Change Username",
            action: () {
              showChangeUsernameModal(
                context,
              );
            },
          ),
          SettingsItem(
            icon: HeroIcons.pencil,
            name: "Edit Name",
            action: () {
              showEditNameModal(
                context,
              );
            },
          ),
          SettingsItem(
            icon: HeroIcons.document,
            name: "Edit Bio",
            action: () {
              showEditBioModal(
                context,
              );
            },
          ),
        ],
      ),
      SizedBox.fromSize(
        size: const Size.fromHeight(8),
      ),
      SettingsGroup(
        name: "Dangerous Settings",
        color: TW3Colors.gray.shade700,
        settings: [
          SettingsItem(
            icon: HeroIcons.archiveBox,
            name: "Archive Account",
            action: () {},
          ),
          SettingsItem(
            icon: HeroIcons.xCircle,
            name: "Delete Account",
            action: () {},
          ),
        ],
      ),
    ],
  );
}
