import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/my_logger.dart';

class PadProvider extends ChangeNotifier {
  PadProvider({this.screenWidth}) {
    // Get screenSize
    // Long == width / Short == height
    MyLogger.debug('(long, short) = (width, height)');
    MyLogger.debug('Init PadProvider cameraSize:($cameraWidth, $cameraHeight)');
    MyLogger.debug('screenWidth: $screenWidth, videoRatio: $videoRatio');
  }
  final double cameraWidth = 800.0;
  final double cameraHeight = 600.0;
  final double videoRatio = 16 / 9;
  final double screenWidth;
  List<Widget> widgetList = [];
  List<Pos> padPosList = [];

  void addPos({
    @required double posX,
    @required double posY,
    @required double screenHeight,
  }) {
    int length = widgetList.length;
    if (length < 4) {
      // Set pos list
      padPosList.add(Pos(
        x: getCorrectPosX(posX, screenHeight, screenWidth, videoRatio),
        y: posY,
        axisX: screenWidth,
        axisY: screenHeight,
      ));
      MyLogger.debug('padPostList.add: ${padPosList[length]}');
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

  void resetPosList() {
    padPosList.clear();
    widgetList.clear();
    MyLogger.debug('$padPosList');
    MyLogger.debug('$widgetList');
    notifyListeners();
  }

  List<double> getPadResult() {
    assert(padPosList.length == 4);
    List<double> result = [];
    for (var i = 0; i < padPosList.length; i++) {
      Pos updatedPos = padPosList[i].applyRatio(cameraWidth, cameraHeight);
      result.add(updatedPos.x);
      result.add(updatedPos.y);
    }
    assert(result.length == 8);
    MyLogger.debug('getPadResult: $result');
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
    // correction
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

class Pos {
  final double axisX;
  final double axisY;
  final double x;
  final double y;
  Pos({
    this.axisX,
    this.axisY,
    this.x,
    this.y,
  }) {
    assert(axisX != null);
    assert(axisY != null);
    assert(x != null);
    assert(y != null);
  }

  @override
  String toString() {
    return '(x:$x, y:$y)';
  }

  Pos applyRatio(double width, double height) {
    double newPosX = this.x * (width / this.axisX);
    double newPosY = this.y * (height / this.axisY);
    MyLogger.debug('newPos = ($newPosX, $newPosY)');
    assert(newPosX <= width);
    assert(newPosY <= height);
    return Pos(
      axisX: width,
      axisY: height,
      x: newPosX,
      y: newPosY,
    );
  }
}

double getCorrectPosX(
    double posX, double screenHeight, double screenWidth, double ratio) {
  // IMAGE CONTAINER IS NOT FULL ALL THE SCREEN
  // REMOVE PADDING OF EACH SIDE
  // SET POS_X (100, 800) to (0, 890)
  double deltaX = (screenWidth - (screenHeight * ratio)) / 2;
  double scaleFactor = screenWidth / (screenHeight * ratio);
  return (posX - deltaX) * scaleFactor;
}
