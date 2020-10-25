import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';

class PadProvider extends ChangeNotifier {
  final double screenWidth;
  final double screenHeight;
  List<Widget> widgetList = [];
  List<double> padPosList = [];
  PadProvider(this.screenWidth, this.screenHeight) {
    MyLogger.debug(
        'Init PadProvider, screen size ($screenWidth, $screenHeight)');
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
      backgroundColor: Colors.orange.withOpacity(0.7),
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
