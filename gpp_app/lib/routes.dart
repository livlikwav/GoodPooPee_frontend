import 'package:flutter/material.dart';

// import 'screens/home/home.dart';
import 'screens/splash/splash.dart';
import 'screens/login/login.dart';
import 'screens/register/register.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  // static const String home = '/home';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    // home: (BuildContext context) => HomeScreen(),
  };
}
