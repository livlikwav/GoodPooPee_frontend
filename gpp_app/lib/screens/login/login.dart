import 'dart:developer' as developer;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';
import 'package:gpp_app/widgets/app_icon_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(), //empty_app_bar_widget
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(flex: 3, child: _buildUpside()),
        Expanded(flex: 2, child: _buildCenterSide()),
        Expanded(flex: 1, child: _buildDownSide()),
      ],
    ));
  }

  Widget _buildUpside() {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(
            flex: 1,
            child:
                Align(alignment: Alignment.bottomCenter, child: Text('굿푸피'))),
        Expanded(
          flex: 3,
          child: Center(child: AppIconWidget(image: Assets.appLogo)),
        ),
        Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.topCenter,
                child: Text('반려견 지능형 배변훈련 서비스'))),
      ],
    ));
  }

  Widget _buildCenterSide() {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(child: Text('아이디 입력')),
        Expanded(child: Text('비밀번호 입력')),
        Expanded(child: Text('확인 버튼')),
      ],
    ));
  }

  Widget _buildDownSide() {
    return Material(
        child: Center(
            child: RichText(
                text: new TextSpan(children: [
      new TextSpan(
        text: '아직 굿푸피 계정이 없으신가요? ',
        style: new TextStyle(color: Colors.black),
      ),
      new TextSpan(
          text: '회원가입',
          style: new TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          recognizer: new TapGestureRecognizer()
            ..onTap = () {
              developer.log('login.dart: register link tapped',
                  name: 'MY.DEBUG', level: 10);
              Navigator.of(context).pushNamed(Routes.register);
            })
    ]))));
  }
}
