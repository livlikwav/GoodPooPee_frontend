import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/constants/text_style.dart';

Widget buildDownSide(BuildContext context, Function registerTapped) {
  return Center(
      child: RichText(
          text: new TextSpan(children: [
    new TextSpan(
        text: '아직 굿푸피 계정이 없으신가요? ',
        style: new TextStyle(fontSize: pStyle.fontSize, color: Colors.black)),
    new TextSpan(
        text: '회원가입',
        style: new TextStyle(
            fontSize: h2Style.fontSize,
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold),
        recognizer: new TapGestureRecognizer()..onTap = registerTapped)
  ])));
}
