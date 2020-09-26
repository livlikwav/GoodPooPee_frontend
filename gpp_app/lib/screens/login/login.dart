import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';
// link rest api
import 'package:gpp_app/models/rest/rest_client.dart';
import 'package:gpp_app/models/exceptions/network_exceptions.dart';
// build screen
import 'components/upside.dart';
import 'components/center_side.dart';
import 'components/downside.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final RestClient restClient = RestClient();
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
    restClient.get('http://localhost:5000');
    // try {
    //   restClient.post(
    //     serverUrl,
    //     body:
    //         "{'email' : ${emailController.text}, 'password' : ${passwordController.text}}",
    //   );
    // } on NetworkException catch (e) {
    //   print(e);
    // }
    // Navigator.of(context).pushNamed(Routes.report);
  }

  void registerTapped() {
    developer.log('login.dart: register link tapped',
        name: 'MY.DEBUG', level: 10);
    Navigator.of(context).pushNamed(Routes.register);
  }
}
