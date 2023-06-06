import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:local/repos/data/models/filter/search.dart';
import 'package:local/screens/post_auth/profile/views/settings/setting_item.dart';
import 'package:local/screens/post_auth/profile/views/settings/settings_group.dart';
import 'package:local/screens/post_auth/searches/views/add_edit_search_modal/add_edit_search_modal.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

void showSearchOptionsModal(
  BuildContext context,
  Search search,
) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    backgroundColor: TW3Colors.gray.shade700,
    isScrollControlled: true,
    builder: (_) {
      return SearchOptionsModal(
        search: search,
      );
    },
  );
}

class SearchOptionsModal extends StatelessWidget {
  const SearchOptionsModal({
    super.key,
    required this.search,
  });

  final Search search;

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
              name: "Search Settings",
              settings: [
                SettingsItem(
                  icon: HeroIcons.pencilSquare,
                  name: "Edit Search",
                  action: () {
                    showAddEditSearchModal(
                      context,
                      search,
                      SearchModalType.edit,
                    );
                  },
                ),
                SettingsItem(
                  icon: HeroIcons.bell,
                  name:
                      "${search.notificationsEnabled ? "Disable" : "Enable"} Notifications",
                  action: () {},
                ),
                SettingsItem(
                  icon: HeroIcons.userGroup,
                  name: "Make ${search.isPublic ? "Private" : "Public"}",
                  action: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SettingsGroup(
              name: "More Seach Settings",
              settings: [
                SettingsItem(
                  icon: HeroIcons.heart,
                  name: "Save Search",
                  action: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            SettingsGroup(
              name: "Oh No",
              settings: [
                SettingsItem(
                  icon: HeroIcons.xCircle,
                  name: "Remove Search",
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
