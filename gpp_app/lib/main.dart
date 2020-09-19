import 'package:flutter/services.dart';
import 'package:gpp_app/constants/constants.dart';
import 'package:gpp_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/screens/splash/splash.dart';
import 'package:gpp_app/constants/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set portraitUp only.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: Strings.appName,
      theme: themeData,
      home: SplashScreen(),
      routes: Routes.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, US
        const Locale('ko', 'KO'), // Korean, Korea
      ],
    );
  }
}
