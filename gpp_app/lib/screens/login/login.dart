import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';
// link rest api
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
// build screen
import 'components/upside.dart';
import 'components/center_side.dart';
import 'components/downside.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DioClient dioClient = DioClient(Dio());
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

  void loginTapped() async {
    developer.log(
      // =============== MUST BE DELETED AFTER FINISH LINKING REST API ===========================
      'Login button tapped\nID: ${emailController.text}\nPW: ${passwordController.text}',
      name: 'DEBUG',
      level: 10,
    );
    Response response;
    // host/user/login POST
    try {
      response = await dioClient.post(
        'http://3.34.105.15:5000/user/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text
        },
      );
      // Handling exception
    } on DioError catch (e) {
      if (e.response != null) {
        developer.log(
          'Login failed. Status code is ${e.response.statusCode}',
          name: 'ERROR',
          level: 10,
        );
        return;
      } else {
        developer.log(
          'Login failed. Error.response is null.\n${e.request}\n${e.message}',
          name: 'ERROR',
          level: 10,
        );
        return;
      }
    }
    // Successed
    if (response != null && response.statusCode == 200) {
      // print(response.data);
      // print(response.data.runtimeType);
      // Dio.post returns map, so just use it
      var userAuth = UserAuth.fromJson(response.data);
      print(userAuth.access_token);
      // Save user auth token
      // final prefs = await SharedPreferences.getInstance();
      // prefs.setInt('userAuth', )

      // Route to report(main) screen
      developer.log(
        'Login successed',
        name: 'DEBUG',
        level: 10,
      );
      // Navigator.of(context).pushNamed(Routes.report);
    }
  }

  void registerTapped() {
    developer.log(
      'Register link tapped',
      name: 'DEBUG',
      level: 10,
    );
    Navigator.of(context).pushNamed(Routes.register);
  }
}
