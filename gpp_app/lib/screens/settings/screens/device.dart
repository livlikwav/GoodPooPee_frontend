import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/default_button.dart';

class SettingDeviceScreen extends StatefulWidget {
  @override
  _SettingDeviceScreenState createState() => _SettingDeviceScreenState();
}

class _SettingDeviceScreenState extends State<SettingDeviceScreen> {
  String nickname = '원씽';
  String nicknameHint = '새 닉네임을 입력하세요';
  String email = 'Gaonrudal@gmail.com';
  String emailHint = '이것이 보이면 오류입니다';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('푸피캠/푸피스낵바 연결')),
      body: _buildBody(context),
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
                    _deviceAvatar(),
                    SizedBox(
                        width: getBlockSizeHorizontal(80),
                        height: getBlockSizeVertical(1)),
                    _subtitle('푸피캠'),
                    _buildTextBox('PPCAM-5T63B', '연결됨'),
                    SizedBox(height: getBlockSizeVertical(1)),
                    _subtitle('푸피스낵바'),
                    _buildTextBox('PPSNACK-12C3E', '연결됨'),
                    SizedBox(height: getBlockSizeVertical(5)),
                    DefaultButton(text: '푸피캠 연결하기', press: _connectPpcam),
                    SizedBox(height: getBlockSizeVertical(1)),
                    DefaultButton(text: '푸피스낵바 연결하기', press: _connectPpsnack),
                    SizedBox(height: getBlockSizeVertical(5)),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildTextBox(String name, String status) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: getBlockSizeHorizontal(5)),
      height: getBlockSizeVertical(7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(status),
        ],
      ),
    );
  }

  CircleAvatar _deviceAvatar() {
    return CircleAvatar(
      radius: getBlockSizeHorizontal(10),
      child: Icon(
        Icons.settings_bluetooth,
        color: Colors.orange,
        size: getBlockSizeHorizontal(10),
      ),
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

  void _connectPpcam() {
    print('connect ppcam tapped');
  }

  void _connectPpsnack() {
    print('connect ppsnack tapped');
  }
}
