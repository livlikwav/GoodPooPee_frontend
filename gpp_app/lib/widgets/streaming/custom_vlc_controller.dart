import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:gpp_app/util/my_logger.dart';

class CustomVlcPlayerController extends VlcPlayerController {
  // Inherit superclass constructor
  CustomVlcPlayerController({VoidCallback onInit, CastCallback onCastHandler})
      : super(onInit: onInit, onCastHandler: onCastHandler);

  // Disposes the platform view and unloads the VLC player.
  @override
  Future<void> dispose() async {
    try {
      // ********** CAUTION : This can cause memory leak. but there is no solution. ***************
      // super.dispose(); // await _methodChannel.invokeMethod("dispose");
    } on MissingPluginException {
      MyLogger.info('Ignore MissingPluginException of controller.dispose');
      MyLogger.info('VlcPlayler automatically disposed well by dart');
    }
  }
}
