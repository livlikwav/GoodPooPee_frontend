import 'package:flutter/material.dart';

class LiveVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: Center(
        child: Text('LiveVideo : 실시간 스트리밍 화면'),
      ),
    );
  }
}
