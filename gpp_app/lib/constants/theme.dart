import 'package:gpp_app/constants/colors.dart';

import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: appBarTheme(),
  // textTheme: textTheme(),
  // Set scaled text size on runtime by text_style.dart
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // Details
  brightness: Brightness.light,
  // primarySwatch: MaterialColor(AppColors.orange[500].value, AppColors.orange),
  primaryColor: AppColors.primaryColor,
  primaryColorBrightness: Brightness.light,
  accentColor: AppColors.secondaryColor,
  accentColorBrightness: Brightness.light,
  backgroundColor: Colors.white,
);

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
