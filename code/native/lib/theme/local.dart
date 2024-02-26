import 'package:flutter/material.dart';

class LocalColors extends ThemeExtension<LocalColors> {
  final MaterialColor postCard;
  final MaterialColor boardCard;
  final MaterialColor onBoardCard;
  final MaterialColor dialogBackground;
  final MaterialColor onDialogBackground;
  final MaterialColor dialogBackgroundHover;

  LocalColors({
    required this.postCard,
    required this.boardCard,
    required this.onBoardCard,
    required this.dialogBackground,
    required this.onDialogBackground,
    required this.dialogBackgroundHover,
  });

  @override
  LocalColors lerp(LocalColors? other, double t) {
    if (other == null) return this;

    return LocalColors(
      postCard: postCard,
      boardCard: boardCard,
      onBoardCard: onBoardCard,
      dialogBackground: dialogBackground,
      onDialogBackground: onDialogBackground,
      dialogBackgroundHover: dialogBackgroundHover,
    );
  }

  @override
  LocalColors copyWith({
    MaterialColor? postCard,
    MaterialColor? boardCard,
    MaterialColor? onBoardCard,
    MaterialColor? dialogBackground,
    MaterialColor? onDialogBackground,
    MaterialColor? dialogBackgroundHover,
  }) {
    return LocalColors(
      postCard: postCard ?? this.postCard,
      boardCard: boardCard ?? this.boardCard,
      onBoardCard: onBoardCard ?? this.onBoardCard,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      onDialogBackground: onDialogBackground ?? this.onDialogBackground,
      dialogBackgroundHover:
          dialogBackgroundHover ?? this.dialogBackgroundHover,
    );
  }
}
