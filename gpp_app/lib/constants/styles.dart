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

  static TextStyle subtitle(Color color) {
    return TextStyle(
      color: color,
      fontSize: getBlockSizeHorizontal(3),
      fontWeight: FontWeight.bold,
    );
  }
}
