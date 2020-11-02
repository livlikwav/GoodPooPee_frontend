import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/buttons.dart';

class SettingUserProfileScreen extends StatefulWidget {
  @override
  _SettingUserProfileScreenState createState() =>
      _SettingUserProfileScreenState();
}

class _SettingUserProfileScreenState extends State<SettingUserProfileScreen> {
  String nickname = '원씽';
  String nicknameHint = '새 닉네임을 입력하세요';
  String email = 'Gaonrudal@gmail.com';
  String emailHint = '이것이 보이면 오류입니다';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(title: Text('회원 정보 설정')),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      color: Theme.of(context).backgroundColor,
      child: Padding(
          padding: EdgeInsets.fromLTRB(
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
            getBlockSizeHorizontal(5),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(getBlockSizeHorizontal(5)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(getBlockSizeHorizontal(5)),
                ),
                child: Column(
                  children: [
                    IconButton(
                      iconSize: getBlockSizeHorizontal(20),
                      icon: _userAvatar(),
                      onPressed: _changeImage,
                    ),
                    SizedBox(
                        width: getBlockSizeHorizontal(80),
                        height: getBlockSizeVertical(5)),
                    _subtitle('이메일'),
                    customTextField(email, emailHint, null, isEnabled: false),
                    SizedBox(height: getBlockSizeVertical(1)),
                    _subtitle('닉네임'),
                    customTextField(nickname, nicknameHint, null,
                        isEnabled: false),
                    SizedBox(height: getBlockSizeVertical(5)),
                    DefaultButton(text: '비밀번호 변경하기', press: _changePassword),
                    SizedBox(height: getBlockSizeVertical(1)),
                    DefaultButton(text: '회원 탈퇴하기', press: _userDelete),
                    SizedBox(height: getBlockSizeVertical(5)),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  CircleAvatar _userAvatar() {
    return CircleAvatar(
      radius: getBlockSizeHorizontal(20),
      backgroundImage: new AssetImage(Assets.appLogo),
    );
  }

  Align _subtitle(String text) {
    return Align(
      child: Padding(
          padding: EdgeInsets.all(
            getBlockSizeHorizontal(2),
          ),
          child: Text(text)),
      alignment: Alignment.centerLeft,
    );
  }

  void _changeImage() {
    print('change image tapped');
  }

  void _changePassword() {
    print('change password tapped');
  }

  void _userDelete() {
    print('user delete tapped');
  }
}
