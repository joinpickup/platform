import 'package:flutter/material.dart';
import 'package:local/shared/presentation/black_button.dart';
import 'package:local/features/locale/presentation/locale_selector.dart';

GlobalKey homeLocaleSelectorKey = GlobalKey();

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            width: 4,
            color: Colors.black,
          ),
          color: Theme.of(context).colorScheme.background,
        ),
        child: Column(
          children: [
            // action row
            Row(
              children: [
                // local
                LocaleSelector(
                  key: homeLocaleSelectorKey,
                ),
                const Spacer(),
                // close button
                BlackButton(
                  icon: Icons.close,
                  click: (context) {
                    Scaffold.of(context).closeDrawer();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
