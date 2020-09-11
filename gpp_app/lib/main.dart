/// Goodpoopee App
/// MAINTAINER : Gyeongmin Ha
/// gaonrudal@gmail.com
///
import 'package:gpp_app/constants/strings.dart';
import 'package:gpp_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/screens/splash/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: SplashScreen(),
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
