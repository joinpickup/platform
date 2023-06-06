import 'package:heroicons/heroicons.dart';

HeroIcons mapStringToHeroIcon(
  String str,
) {
  switch (str.toLowerCase()) {
    case "music":
      return HeroIcons.musicalNote;
    case "sports":
      return HeroIcons.trophy;
    case "tabletop":
      return HeroIcons.puzzlePiece;
    case "books":
      return HeroIcons.bookOpen;
    default:
      return HeroIcons.document;
  }
}
