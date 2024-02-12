import 'package:flutter/material.dart';

class LocalColors extends ThemeExtension<LocalColors> {
  final MaterialColor postCard;
  final MaterialColor boardCard;
  final MaterialColor onBoardCard;

  LocalColors({
    required this.postCard,
    required this.boardCard,
    required this.onBoardCard,
  });

  @override
  LocalColors lerp(LocalColors? other, double t) {
    if (other == null) return this;

    return LocalColors(
      postCard: postCard,
      boardCard: boardCard,
      onBoardCard: onBoardCard,
    );
  }

  @override
  LocalColors copyWith({
    MaterialColor? postCard,
    MaterialColor? boardCard,
    MaterialColor? onBoardCard,
  }) {
    return LocalColors(
      postCard: postCard ?? this.postCard,
      boardCard: boardCard ?? this.boardCard,
      onBoardCard: onBoardCard ?? this.onBoardCard,
    );
  }
}
