import 'package:flutter/material.dart';
import 'package:gpp_app/util/size_config.dart';

class Layouts {
  Layouts._();

  static EdgeInsets margin() => EdgeInsets.all(getBlockSizeVertical(2));
  static EdgeInsets padding() => EdgeInsets.all(getBlockSizeVertical(2));

  static SizedBox customSpacer() => SizedBox(
        height: getBlockSizeVertical(1),
      );
}
