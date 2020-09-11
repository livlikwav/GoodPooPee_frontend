import 'package:flutter/material.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';

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
      children: <Widget>[
        Expanded(flex: 1, child: Text(' ')),
        Expanded(flex: 4, child: _buildUpSide()),
        Expanded(flex: 1, child: Text(' ')),
        Expanded(flex: 1, child: _buildDownSide()),
        Expanded(flex: 2, child: Text(' ')),
      ],
    ));
  }

  Widget _buildUpSide() {
    return Material(
        child: Column(
      children: <Widget>[
        Expanded(child: Center(child: Text('굿푸피 계정을 만드세요'))),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '이메일',
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '성함',
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '비밀번호',
            ),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '비밀번호 확인',
            ),
          ),
        ),
        Expanded(
            child: Center(
                child: Text(
                    'By creating account you agree to our Terms of Service and Privacy Policy'))),
      ],
    ));
  }

  Widget _buildDownSide() {
    return Material(
      child: RaisedButton(
        child: Text('확인'),
        onPressed: clickMe,
        textColor: Colors.white,
        color: Colors.black,
      ),
    );
  }

  void clickMe() {
    print('Clicked');
  }
}
