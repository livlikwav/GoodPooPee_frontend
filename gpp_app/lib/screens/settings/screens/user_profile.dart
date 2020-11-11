import 'package:flutter/material.dart';
import 'package:gpp_app/constants/colors.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_app_bar.dart';
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
        appBar: customAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(getBlockSizeHorizontal(5)),
            padding: EdgeInsets.all(getBlockSizeHorizontal(5)),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(getBlockSizeHorizontal(5)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.person,
                  size: getBlockSizeVertical(5),
                  color: AppColors.accentColor,
                ),
                SizedBox(height: getBlockSizeVertical(1)),
                _subtitle('이메일'),
                customTextField(context, email, emailHint, null,
                    isEnabled: false),
                SizedBox(height: getBlockSizeVertical(1)),
                _subtitle('닉네임'),
                customTextField(context, nickname, nicknameHint, null,
                    isEnabled: false),
                SizedBox(height: getBlockSizeVertical(5)),
                DefaultButton(text: '비밀번호 변경하기', press: _changePassword),
                SizedBox(height: getBlockSizeVertical(1)),
                DefaultButton(text: '회원 탈퇴하기', press: _userDelete),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Align _subtitle(String text) {
    return Align(
      child: Padding(
          padding: EdgeInsets.all(
            getBlockSizeVertical(1),
          ),
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      alignment: Alignment.centerLeft,
    );
  }

  // void _changeImage() {
  //   print('change image tapped');
  // }

  void _changePassword() {
    print('change password tapped');
  }

  void _userDelete() {
    print('user delete tapped');
  }
}
