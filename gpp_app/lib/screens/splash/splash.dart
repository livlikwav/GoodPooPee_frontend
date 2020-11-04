import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/screens/splash/fade_in_logo.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: FadeInLogo(),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    MyLogger.info('Splash timer initialized');
    return Timer(_duration, navigate);
  }

  navigate() async {
    // -----if login moudle completed-----
    //  SharedPreferences preferences = await SharedPreferences.getInstance();

    // In Dart, ?? operator check that left var is null
    // if (preferences.getBool(Preferences.is_logged_in) ?? false) {
    //   Navigator.of(context).pushNamed(Routes.home);
    // } else {
    //   Navigator.of(context).pushNamed(Routes.login);
    // }

    Navigator.of(context).pushReplacementNamed(Routes.login);
  }
}
