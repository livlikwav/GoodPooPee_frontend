import 'package:flutter/material.dart';

// import 'screens/home/home.dart';
import 'screens/splash/splash.dart';
import 'screens/login/login.dart';
import 'screens/register/register.dart';
import 'screens/report/report.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String report = '/report';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    report: (BuildContext context) => ReportScreen(),
  };
}
