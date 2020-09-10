import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        child: Column(
      children: <Widget>[Text('register screen body')],
    ));
  }
}
