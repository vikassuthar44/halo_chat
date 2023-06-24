import 'package:flutter/material.dart';

import 'color_theme.dart';
import 'colors.dart';
import 'text_theme.dart';

ThemeData haloTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    scaffoldBackgroundColor: ColorClass.background,
    textTheme: TextThemeClass.textLightTheme,
    colorScheme: ColorTheme.lightColorScheme
  );
}