import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/services/post_ppsnack_feeding.dart';
import 'package:gpp_app/util/my_logger.dart';
// import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/image_alert_dialog.dart';
import 'package:gpp_app/widgets/streaming/custom_vlc_controller.dart';

class CustomStreamingMenu extends StatelessWidget {
  CustomStreamingMenu(this.controller, this.ppcamId);
  final CustomVlcPlayerController controller;
  final int ppcamId;
  // final double _ringDiameter = getBlockSizeVertical(50);
  // final double _ringWidth = getBlockSizeVertical(7);
  final double _ringDiameter = 250.0;
  final double _ringWidth = 50.0;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      // Ring rendered before orientation changed
      ringDiameter: _ringDiameter,
      ringWidth: _ringWidth,
      fabOpenColor: Colors.white,
      fabColor: AppColors.primaryColor,
      ringColor: AppColors.primaryColor,
      fabOpenIcon: Icon(
        Icons.menu,
        color: Colors.white,
      ),
      children: <Widget>[
        _backMenu(context),
        _captureMenu(context),
        _feedMenu(context, ppcamId),
      ],
    );
  }

  IconButton _feedMenu(BuildContext context, int ppcamId) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.fastfood),
      onPressed: () {
        MyLogger.info('Feeding button tapped');
        postPpsnackFeeding(context, ppcamId);
      },
    );
  }

  IconButton _captureMenu(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.camera_alt),
      onPressed: () async {
        MyLogger.info('Capture button tapped');
        Uint8List image = await controller.takeSnapshot();
        showImageDialog(context, image);
      },
    );
  }

  IconButton _backMenu(BuildContext context) {
    return IconButton(
      color: Colors.white,
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        MyLogger.info('Exit button tapped');
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
