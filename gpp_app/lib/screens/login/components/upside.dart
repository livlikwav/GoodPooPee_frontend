import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/constants/text_style.dart';
import 'package:gpp_app/widgets/app_icon_widget.dart';

Widget buildUpSide() {
  return Column(
    children: <Widget>[
      Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: Text('굿푸피', style: h1Style))),
      Expanded(
        flex: 2,
        child: Center(child: AppIconWidget(image: Assets.appLogo)),
      ),
      Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.topCenter,
              child: Text('반려견 지능형 배변훈련 서비스',
                  style: new TextStyle(
                    fontSize: h3Style.fontSize,
                    color: Colors.black,
                  )))),
    ],
  );
}
