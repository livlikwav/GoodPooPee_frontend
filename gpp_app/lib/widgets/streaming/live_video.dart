import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/streaming/custom_vlc_controller.dart';

class LiveVideo extends StatefulWidget {
  LiveVideo(this.url, this.controller);
  final String url;
  final CustomVlcPlayerController controller;
  @override
  State<StatefulWidget> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  @override
  void initState() {
    MyLogger.debug('LiveVideo url : ${widget.url}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: VlcPlayer(
          // aspectRatio: 4 / 3,
          aspectRatio: 16 / 9,
          url: widget.url,
          controller: widget.controller,
          placeholder: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
