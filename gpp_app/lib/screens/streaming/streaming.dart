import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp_app/screens/streaming/components/custom_circular_menu.dart';
import 'package:gpp_app/screens/streaming/components/live_video.dart';
import 'package:gpp_app/widgets/drawer_menu.dart';

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
    return Scaffold(
      primary: true,
      body: _buildBody(context),
      floatingActionButton: CustomCircularMenu(),
      // DEBUG
      // appBar: AppBar(
      //   title: Text('DEBUG : 내 푸피캠 확인하기'),
      //   // leading: _backButton(),
      // ),
    );
  }

  Widget _buildBody(context) {
    return SizedBox(
      width: double.infinity,
      child: LiveVideo(),
    );
  }
}