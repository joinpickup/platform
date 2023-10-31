import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local/features/home/presentation/home_drawer.dart';
import 'package:local/features/locale/application/locale_bloc/locale_bloc_bloc.dart';
import 'package:local/features/locale/presentation/locale_dialog.dart';
import 'package:local/features/locale/domain/locale.dart';
import 'package:local/shared/application/app/app_bloc.dart';
import 'package:local/support/position.dart';

class LocaleSelector extends StatefulWidget {
  const LocaleSelector({
    super.key,
  });

  @override
  State<LocaleSelector> createState() => _LocaleSelectorState();
}

class _LocaleSelectorState extends State<LocaleSelector> {
  OverlayEntry? _localeOverlay;
  bool _isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, localeState) {
        return BlocBuilder<AppBloc, AppState>(builder: (context, appState) {
          return GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              if (!_isMenuOpen) {
                openMenu(context);
              } else {
                closeMenu();
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-1, 1),
                    blurRadius: 8,
                    color: Colors.black,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    "test",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }

  OverlayEntry _localeOverlayBuilder(context) {
    LocaleBloc localeBloc = BlocProvider.of<LocaleBloc>(context);

    return OverlayEntry(
      builder: (_) {
        return BlocProvider.value(
          value: localeBloc,
          child: Stack(
            children: [
              ModalBarrier(
                onDismiss: () {
                  closeMenu();
                },
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 30),
                top: getOffsetFromKey(homeLocaleSelectorKey).dy +
                    getSizeFromKey(homeLocaleSelectorKey).height,
                left: getOffsetFromKey(homeLocaleSelectorKey).dx,
                width: 300,
                child: const Material(
                  color: Colors.transparent,
                  child: LocaleDialog(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void openMenu(context) {
    _localeOverlay = _localeOverlayBuilder(context);
    Overlay.of(context).insert(_localeOverlay as OverlayEntry);
    _isMenuOpen = !_isMenuOpen;
  }

  void closeMenu() {
    _localeOverlay?.remove();
    _isMenuOpen = !_isMenuOpen;
  }
}
