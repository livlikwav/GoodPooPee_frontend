import 'package:flutter/material.dart';

// import 'screens/home/home.dart';
import 'screens/splash/splash.dart';
import 'screens/login/login.dart';
import 'screens/register/register.dart';
import 'screens/report/report.dart';
import 'screens/streaming/streaming.dart';
import 'screens/logs/logs.dart';
// Setting screen dart files
import 'screens/settings/settings.dart';
import 'screens/settings/screens/user_profile.dart';
import 'screens/settings/screens/pet_profile.dart';
import 'screens/settings/screens/feedback.dart';
import 'screens/settings/screens/pad/pad.dart';
import 'screens/settings/screens/device.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String report = '/report';
  static const String streaming = '/streaming';
  static const String logs = '/logs';
  // Setting screens
  static const String settings = '/settings';
  static const String setting_user_profile = '/setting_user_profile';
  static const String setting_pet_profile = '/setting_pet_profile';
  static const String setting_feedback = '/setting_feedback';
  static const String setting_pad = '/setting_pad';
  static const String setting_device = '/setting_device';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    register: (BuildContext context) => RegisterScreen(),
    report: (BuildContext context) => ReportScreen(),
    streaming: (BuildContext context) => StreamingScreen(),
    logs: (BuildContext context) => LogsScreen(),
    // Setting routes
    settings: (BuildContext context) => SettingsScreen(),
    setting_user_profile: (BuildContext context) => SettingUserProfileScreen(),
    setting_pet_profile: (BuildContext context) => SettingPetProfileScreen(),
    setting_feedback: (BuildContext context) => SettingFeedbackScreen(),
    setting_pad: (BuildContext context) => SettingPadScreen(),
    setting_device: (BuildContext context) => SettingDeviceScreen(),
  };
}
