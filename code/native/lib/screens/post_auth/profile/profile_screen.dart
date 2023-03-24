import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/repos/data/mocks/person.dart';
import 'package:local/repos/data/models/user/person.dart';
import 'package:local/screens/post_auth/messages/messages_screen.dart';
import 'package:local/screens/post_auth/notifications/notifications_screen.dart';
import 'package:local/screens/post_auth/person/person_screen.dart';
import 'package:local/screens/post_auth/profile/views/modules/module.dart';
import 'package:local/screens/post_auth/profile/views/settings/edit_profile_screen.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:local/screens/post_auth/profile/views/settings/theme_picker_screen.dart';
import 'package:local/screens/post_auth/profile/views/settings/verify_profile_screen.dart';
import 'package:local/shared/auth_feed/auth_bloc.dart';
import 'package:tailwind_colors/tailwind_colors.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _privacy = Uri.parse("https://joinpickup.com/apps/platform");
final Uri _terms = Uri.parse('https://joinpickup.com/apps/platform');

Future<void> _launchUrl(Uri url) async {
  await launchUrl(url);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final person =
            allPersons.firstWhere((p) => p.userID == state.user!.userID);
        return Scaffold(
          backgroundColor: TW3Colors.gray.shade600,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: _buildAppBar(context, person),
          ),
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: ListView(
                children: [
                  const Text("Modules"),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Module(
                        icon: HeroIcons.chatBubbleLeft,
                        text: "Messages",
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const MessagesScreen();
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Module(
                        icon: HeroIcons.bell,
                        text: "Notifications",
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const NotificationsScreen();
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text("Settings"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildProfileSettings(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget _buildAppBar(BuildContext context, Person person) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: SafeArea(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PersonScreen(
              personID: person.personID,
            ),
          ));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(36),
                child: Image.asset(person.avatar, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  person.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  "View Profile",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget _buildProfileSettings(BuildContext context) {
  return Column(
    children: [
      SettingsGroup(
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
            action: () {
              context.read<AuthBloc>().add(Logout());
            },
            hasArrow: false,
          ),
        ],
      ),
      SizedBox.fromSize(
        size: const Size.fromHeight(8),
      ),
      SettingsGroup(
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
          SettingsItem(
            icon: HeroIcons.documentText,
            name: "Terms Of Service",
            action: () {
              _launchUrl(_terms);
            },
          ),
          SettingsItem(
            icon: HeroIcons.eye,
            name: "Privacy Policy",
            action: () {
              _launchUrl(_privacy);
            },
          ),
        ],
      ),
    ],
  );
}
