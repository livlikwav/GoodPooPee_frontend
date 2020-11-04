import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';

AppBar customAppBar({IconButton refreshIcon}) {
  return AppBar(
    title: null,
    backgroundColor: AppColors.backgroundColor,
    actions: refreshIcon != null
        ? <Widget>[
            refreshIcon,
          ]
        : null,
  );
}
