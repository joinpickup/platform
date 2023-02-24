import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';

class DiscoverScreen extends HookWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: HeroIcon(
          HeroIcons.userGroup,
        ),
        middle: CupertinoSearchTextField(),
        trailing: HeroIcon(
          HeroIcons.plus,
        ),
      ),
      child: Container(),
    );
  }
}
