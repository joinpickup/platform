import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

class ManageLoginsScreen extends StatefulWidget {
  const ManageLoginsScreen({super.key});

  @override
  State<ManageLoginsScreen> createState() => _ManageLoginsScreenState();
}

class _ManageLoginsScreenState extends State<ManageLoginsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Logins"),
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
            icon: HeroIcons.envelope,
            name: "Basic Email Login",
            action: () {},
          ),
          SettingsItem(
            icon: HeroIcons.pencil,
            name: "Connect to Apple",
            action: () {},
          ),
          SettingsItem(
            icon: HeroIcons.pencil,
            name: "Discord Login",
            action: () {},
          ),
          SettingsItem(
            icon: HeroIcons.document,
            name: "Sign in with Google",
            action: () {},
          ),
        ],
      ),
    ],
  );
}
