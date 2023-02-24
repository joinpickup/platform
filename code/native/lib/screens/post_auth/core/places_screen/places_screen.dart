import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';

class PlacesScreen extends HookWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: CupertinoSearchTextField(),
        trailing: HeroIcon(
          HeroIcons.plus,
        ),
      ),
      child: Container(),
    );
  }
}
