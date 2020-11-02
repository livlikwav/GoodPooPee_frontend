import 'package:flutter/material.dart';
import 'package:gpp_app/services/login_tap.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/buttons.dart';

Widget buildCenterSide(BuildContext context) {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController pwCtrl = TextEditingController();

  return Column(
    children: <Widget>[
      customTextField(
        "이메일",
        "이메일을 입력하세요",
        emailCtrl,
      ),
      customTextField(
        "비밀번호",
        "비밀번호를 입력하세요",
        pwCtrl,
        obscure: true,
      ),
      DefaultButton(
          text: '확인',
          press: () {
            loginTapped(context, emailCtrl.text, pwCtrl.text);
          }),
    ],
  );
}
