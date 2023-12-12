import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData getTheme() {
  return ThemeData(
    fontFamily: 'SF',
    scaffoldBackgroundColor: ColorsUI.scaffoldColor,
    textTheme: const TextTheme(
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorsUI.mainText,
        fontSize: 24,
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
    ),
  );
}
