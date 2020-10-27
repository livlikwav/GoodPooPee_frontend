import 'dart:ui';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class CustomVlcPlayerController extends VlcPlayerController {
  // Inherit superclass constructor
  CustomVlcPlayerController({VoidCallback onInit, CastCallback onCastHandler})
      : super(onInit: onInit, onCastHandler: onCastHandler);

  // Disposes the platform view and unloads the VLC player.
  @override
  Future<void> dispose() async {
    // ********** CAUTION : This can cause memory leak. but there is no solution. ***************
    // super.dispose(); // await _methodChannel.invokeMethod("dispose");
  }
}
