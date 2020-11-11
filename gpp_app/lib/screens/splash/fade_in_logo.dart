import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/widgets/app_icon_widget.dart';

class FadeInLogo extends StatefulWidget {
  @override
  _FadeInLogoState createState() => _FadeInLogoState();
}

class _FadeInLogoState extends State<FadeInLogo> {
  bool isVisible = false;
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      isVisible = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 500),
        child: AppIconWidget(image: Assets.appLogo),
      ),
    );
  }
}
