import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';

class CustomCircularMenu extends StatelessWidget {
  // final double _ringDiameter = getBlockSizeVertical(50);
  // final double _ringWidth = getBlockSizeVertical(10);
  final double _ringDiameter = 250.0;
  final double _ringWidth = 50.0;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      // Ring rendered before orientation changed
      ringDiameter: _ringDiameter,
      ringWidth: _ringWidth,
      fabOpenColor: Colors.white,
      children: <Widget>[
        _backMenu(context),
        _captureMenu(),
        _feedMenu(),
      ],
    );
  }

  IconButton _feedMenu() {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.fastfood),
      onPressed: () {
        developer.log(
          'streaming.dart>customCircularMenu: feed menu item tapped',
          name: 'MY.DEBUG',
          level: 10,
        );
      },
    );
  }

  IconButton _captureMenu() {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.camera_alt),
      onPressed: () {
        developer.log(
          'streaming.dart>customCircularMenu: capture menu item tapped',
          name: 'MY.DEBUG',
          level: 10,
        );
      },
    );
  }

  IconButton _backMenu(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        // set portraitUp orientation
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        Navigator.of(context).pop();
      },
    );
  }

  // IconButton _micMenu() {
  //   return IconButton(
  //     color: Colors.white,
  //     icon: Icon(Icons.mic),
  //     onPressed: () {
  //       developer.log(
  //         'streaming.dart>customCircularMenu: mic menu item tapped',
  //         name: 'MY.DEBUG',
  //         level: 10,
  //       );
  //     },
  //   );
  // }
}
