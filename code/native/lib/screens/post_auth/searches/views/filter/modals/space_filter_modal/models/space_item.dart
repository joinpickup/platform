import 'package:heroicons/heroicons.dart';

class SpaceItem {
  final String name;
  final HeroIcons icon;
  bool isSelected;

  SpaceItem({
    required this.name,
    required this.icon,
    this.isSelected = false,
  });
}
