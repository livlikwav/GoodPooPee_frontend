import 'package:flutter/widgets.dart';

class SizeConfig {
  // Scale size by 100 * 100 grid
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static Orientation orientation;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    // init size config
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    // init orientation
    orientation = _mediaQueryData.orientation;
    // init SafeArea size config
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

double getBlockSizeHorizontal(double blockNum) {
  return SizeConfig.blockSizeHorizontal * blockNum;
}

double getBlockSizeVertical(double blockNum) {
  return SizeConfig.blockSizeVertical * blockNum;
}

double getSafeAreaHorizontal(double blockNum) {
  return SizeConfig.safeBlockHorizontal * blockNum;
}

double getSafeAreaVertical(double blockNum) {
  return SizeConfig.safeBlockVertical * blockNum;
}

// // Get the proportionate height as per screen size
// double getProportionateScreenHeight(double inputHeight) {
//   double screenHeight = SizeConfig.screenHeight;
//   // 812 is the layout height that designer use
//   return (inputHeight / 812.0) * screenHeight;
// }

// // Get the proportionate height as per screen size
// double getProportionateScreenWidth(double inputWidth) {
//   double screenWidth = SizeConfig.screenWidth;
//   // 375 is the layout width that designer use
//   return (inputWidth / 375.0) * screenWidth;
// }
