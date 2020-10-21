import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp_app/screens/streaming/components/custom_circular_menu.dart';
import 'package:gpp_app/widgets/streaming/live_video.dart';

class StreamingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  String ppcamUrl;

  @override
  void initState() {
    // Set url in ppcam profile
    // 'http://beachreachpeach.iptime.org:9981'
    // 'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4'
    ppcamUrl =
        'http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_60fps_normal.mp4';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // set Landscape orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return SafeArea(
      child: Scaffold(
        primary: true,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: LiveVideo(ppcamUrl),
        ),
        floatingActionButton: CustomCircularMenu(),
      ),
    );
  }
}
