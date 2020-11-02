import 'package:flutter/material.dart';
import 'package:gpp_app/services/login_tap.dart';
import 'package:gpp_app/widgets/rounded_button.dart';
import 'package:gpp_app/widgets/rounded_input_field.dart';

class CenterSide extends StatefulWidget {
  @override
  _CenterSideState createState() => _CenterSideState();
}

class _CenterSideState extends State<CenterSide> {
  String emailText;
  String pwText;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RoundedInputField(
          hintText: '이메일',
          onChanged: (value) => emailText = value,
        ),
        RoundedInputField(
          hintText: '비밀번호',
          onChanged: (value) => pwText = value,
          icon: Icons.lock,
          isObscure: true,
        ),
        RoundedButton(
            text: '확인',
            press: () {
              loginTapped(context, emailText, pwText);
              print(emailText);
            }),
      ],
    );
  }
}
