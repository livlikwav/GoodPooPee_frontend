import 'package:flutter/material.dart';
import 'package:gpp_app/constants/text_style.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/default_button.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('굿푸피 회원가입')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Material(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildUpSide(),
        SizedBox(height: getBlockSizeVertical(15)),
        _buildDownSide(),
      ],
    ));
  }

  Widget _buildUpSide() {
    return Material(
        child: Column(
      children: <Widget>[
        Center(
          child: Text(
            '굿푸피 계정을 만드세요',
            style: h2Style,
          ),
        ),
        SizedBox(height: getBlockSizeVertical(2)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: CustomTextField('이메일', '당신의 이메일을 입력하세요'),
        ),
        SizedBox(height: getBlockSizeVertical(1)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: CustomTextField('닉네임', '당신의 닉네임을 입력하세요'),
        ),
        SizedBox(height: getBlockSizeVertical(1)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: CustomTextField('비밀번호', '당신의 비밀번호를 입력하세요'),
        ),
        SizedBox(height: getBlockSizeVertical(1)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: CustomTextField('닉네임', '비밀번호를 한번 더 입력하세요'),
        ),
        SizedBox(height: getBlockSizeVertical(2)),
        Container(
          width: getBlockSizeHorizontal(70),
          height: getBlockSizeVertical(7),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                'By creating account you agree to our Terms of Service and Privacy Policy',
                style: footerStyle,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildDownSide() {
    return Container(
      width: getBlockSizeHorizontal(70),
      child: DefaultButton(
        text: '확인',
        press: onPressed,
      ),
    );
  }

  void onPressed() {
    print('Clicked');
  }
}
