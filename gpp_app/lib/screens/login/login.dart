import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(), //empty_app_bar_widget
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Material(
        child: Container(
            height: 360,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // 주 축 기준 중앙
              crossAxisAlignment: CrossAxisAlignment.center, // 교차 축 기준 중앙
              children: <Widget>[
                FlutterLogo(),
                Text('Hello, Flutter Beginner!'),
                Icon(Icons.sentiment_very_satisfied),
              ],
            )));
  }
}
