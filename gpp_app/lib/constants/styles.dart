import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';

class Styles {
  Styles._();

  static TextStyle accentTitle() {
    return TextStyle(
      color: AppColors.accentColor,
      fontSize: getBlockSizeHorizontal(5),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle greyTitle() {
    return TextStyle(
      color: Colors.black.withOpacity(0.6),
      fontSize: getBlockSizeHorizontal(5),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle subtitle1(Color color) {
    return TextStyle(
      color: color,
      fontSize: getBlockSizeHorizontal(5),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle subtitle2(Color color) {
    return TextStyle(
      color: color,
      fontSize: getBlockSizeHorizontal(3),
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle grade(Color color) {
    return TextStyle(
      color: color,
      fontSize: getBlockSizeHorizontal(8),
      fontWeight: FontWeight.bold,
      // fontStyle: FontStyle.italic,
    );
  }
}
