import 'package:gpp_app/constants/colors.dart';

import 'package:flutter/material.dart';

final kPrimaryColor = AppColors.orange[700];
final kAccentColor = AppColors.orange[500];
final kTextColor = Colors.black;

final ThemeData themeData = new ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme(),
    // textTheme: textTheme(),
    // Set scaled text size on runtime by text_style.dart
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Details
    brightness: Brightness.light,
    primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
    primaryColor: kPrimaryColor,
    primaryColorBrightness: Brightness.light,
    accentColor: kAccentColor,
    accentColorBrightness: Brightness.light);

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Colors.black, fontSize: 18),
    ),
  );
}
