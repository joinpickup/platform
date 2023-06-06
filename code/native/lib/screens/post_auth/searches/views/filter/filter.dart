import 'package:heroicons/heroicons.dart';

enum FilterType { space, interests, age, distance, title, description }

class Filter {
  final String name;
  final HeroIcons icon;
  final String value;
  final FilterType type;
  bool isActive;

  Filter({
    required this.name,
    required this.icon,
    required this.value,
    required this.type,
    this.isActive = false,
  });
}
