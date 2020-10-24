import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';

class PadProvider extends ChangeNotifier {
  final double screenWidth;
  final double screenHeight;
  List<Widget> widgetList;
  PadProvider(this.screenWidth, this.screenHeight) {
    MyLogger.debug(
        'Init PadProvider, screen size ($screenWidth, $screenHeight)');
    widgetList = [];
  }

  void add(double posX, double posY) {
    if (widgetList.length < 4) {
      widgetList.add(_getCircle(
        number: widgetList.length + 1,
        posX: posX,
        posY: posY,
      ));
      MyLogger.debug('$widgetList');
    }
    notifyListeners();
  }

  void reset() {
    widgetList.clear();
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
