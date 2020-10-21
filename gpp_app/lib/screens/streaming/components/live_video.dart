import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class LiveVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  final String urlToStreamVideo = 'http://beachreachpeach.iptime.org:9981';
  VlcPlayerController controller;
  final double playerWidth = 640;
  final double playerHeight = 360;

  @override
  Widget build(BuildContext context) {
    // MUST init controller
    controller = VlcPlayerController(
      onInit: () {
        controller.play();
      },
    );

    return Scaffold(
      body: SizedBox(
        height: playerHeight,
        width: playerWidth,
        child: new VlcPlayer(
          aspectRatio: 16 / 9,
          url: urlToStreamVideo,
          controller: controller,
          placeholder: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
