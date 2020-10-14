import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gpp_app/constants/constants.dart';
import 'package:gpp_app/constants/theme.dart';
import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/screens/splash/splash.dart';
import 'package:provider/provider.dart';

class GppApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set portraitUp only.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProfile>(create: (context) => UserProfile()),
        ChangeNotifierProvider<PetProfile>(create: (context) => PetProfile()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
