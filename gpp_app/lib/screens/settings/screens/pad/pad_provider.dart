import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/my_logger.dart';

class PadProvider extends ChangeNotifier {
  final double cameraWidth = 800.0;
  final double cameraHeight = 600.0;
  final double screenWidth;
  final double screenHeight;
  double widthRatio;
  double heightRatio;
  List<Widget> widgetList = [];
  List<double> padPosList = [];
  PadProvider(this.screenWidth, this.screenHeight) {
    // Compute ratio
    widthRatio = cameraWidth / screenWidth;
    heightRatio = cameraHeight / screenHeight;
    MyLogger.debug(
        'Init PadProvider, screen size ($screenWidth, $screenHeight)');
    MyLogger.debug('camera size ($cameraWidth, $cameraHeight)');
    MyLogger.debug('Ratio ($widthRatio, $heightRatio)');
  }

  void add(double posX, double posY) {
    int length = widgetList.length;
    if (length < 4) {
      // Set pos list
      padPosList.add(posX);
      padPosList.add(posY);
      // Set circle widget
      widgetList.add(_getCircle(
        number: length + 1,
        posX: posX,
        posY: posY,
      ));
      MyLogger.debug('$widgetList');
      MyLogger.debug('$padPosList');
    }
    notifyListeners();
  }

  void reset() {
    padPosList.clear();
    widgetList.clear();
    MyLogger.debug('$padPosList');
    MyLogger.debug('$widgetList');
    notifyListeners();
  }

  List<double> getPosListOfCamera() {
    if (padPosList.length != 8) {
      throw Exception('getPosListOfCamera padPosList.length != 8');
    }
    List<double> result = List.generate(
        padPosList.length,
        (index) => index % 2 == 0
            ? padPosList[index] * widthRatio
            : padPosList[index] * heightRatio);
    MyLogger.debug('PosListOfCamera: $result');
    return result;
  }
}

Widget _getCircle({
  @required int number,
  @required double posX,
  @required double posY,
}) {
  // The default radius if nothing is specified.
  // static const double _defaultRadius = 20.0;
  return Positioned(
    left: posX - 20.0,
    top: posY - 20.0,
    child: CircleAvatar(
      backgroundColor: AppColors.primaryColor.withOpacity(0.7),
      child: Text(
        '$number',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
