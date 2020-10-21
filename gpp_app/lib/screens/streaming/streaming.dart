import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp_app/screens/streaming/components/custom_circular_menu.dart';
import 'package:gpp_app/screens/streaming/components/live_video.dart';

class StreamingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  @override
  void initState() {
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
        body: _buildBody(context),
        floatingActionButton: CustomCircularMenu(),
      ),
    );
  }

  Widget _buildBody(context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: LiveVideo(),
    );
  }
}
