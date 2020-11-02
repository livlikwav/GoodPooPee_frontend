import 'package:gpp_app/constants/colors.dart';

import 'package:flutter/material.dart';

const customTextTheme = const TextTheme(
  headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
  headline2: TextStyle(fontSize: 30.0, fontWeight: FontWeight.normal),
  subtitle1: TextStyle(fontSize: 25.0, fontWeight: FontWeight.normal),
  bodyText1: TextStyle(fontSize: 17.0, fontWeight: FontWeight.normal),
  button: TextStyle(
      fontSize: 15.0, color: Colors.white, fontWeight: FontWeight.normal),
);

final ThemeData themeData = new ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: appBarTheme(),
  fontFamily: 'NotoSansKR',
  textTheme: customTextTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  // Details
  brightness: Brightness.light,
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
