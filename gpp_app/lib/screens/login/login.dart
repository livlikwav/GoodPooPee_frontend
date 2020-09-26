import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/screens/login/components/upside.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';

import 'components/center_side.dart';
import 'components/downside.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(flex: 5, child: buildUpSide()),
        Expanded(
            flex: 3,
            child: buildCenterSide(
              loginTapped,
              emailController,
              passwordController,
            )),
        Expanded(flex: 2, child: buildDownSide(context, registerTapped)),
      ],
    ));
  }

  void loginTapped() {
    developer.log(
        'login.dart>login.tapped\n${emailController.text}\n${passwordController.text}',
        name: 'MY.DEBUG',
        level: 10);
    Navigator.of(context).pushNamed(Routes.report);
  }

  void registerTapped() {
    developer.log('login.dart: register link tapped',
        name: 'MY.DEBUG', level: 10);
    Navigator.of(context).pushNamed(Routes.register);
  }
}
