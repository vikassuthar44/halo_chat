import 'package:flutter/material.dart';
import 'package:halo/util/colors.dart';

@immutable
class ColorTheme {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: ColorClass.lightPink,
    onPrimary: ColorClass.lightPink,
    secondary: ColorClass.veryLightPink,
    onSecondary: ColorClass.veryLightPink,
    tertiaryContainer: ColorClass.brown,
    onTertiaryContainer: ColorClass.white,
    error: ColorClass.red,
    onError: ColorClass.white,
    background: ColorClass.white,
    onBackground: ColorClass.white,
    surface: ColorClass.white,
    onSurface: ColorClass.lightOrange,
  );
}