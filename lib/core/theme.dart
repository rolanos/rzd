import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'SF',
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorsUI.mainText,
        fontSize: 24,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorsUI.mainText,
        fontSize: 20,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorsUI.secondaryText,
        fontSize: 24,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorsUI.mainText,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorsUI.mainText,
        fontSize: 16,
      ),
    ),
  );
}
