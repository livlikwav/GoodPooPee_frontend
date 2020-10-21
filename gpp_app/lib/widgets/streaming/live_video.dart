import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:gpp_app/widgets/streaming/custom_vlc_controller.dart';

class LiveVideo extends StatefulWidget {
  LiveVideo(this.url);
  final String url;
  @override
  State<StatefulWidget> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  final double playerWidth = double.infinity;
  final double playerHeight = double.infinity;
  CustomVlcPlayerController _controller;

  @override
  void initState() {
    // init controller
    _controller = CustomVlcPlayerController(
      onInit: () {
        _controller.play();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: playerHeight,
        width: playerWidth,
        child: VlcPlayer(
          aspectRatio: 16 / 9,
          url: widget.url,
          controller: _controller,
          placeholder: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
