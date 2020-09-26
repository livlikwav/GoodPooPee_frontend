import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/default_button.dart';

class SettingPetProfileScreen extends StatefulWidget {
  @override
  _SettingPetProfileScreenState createState() =>
      _SettingPetProfileScreenState();
}

class _SettingPetProfileScreenState extends State<SettingPetProfileScreen> {
  String birth = 'YYYY-MM-DD';
  String birthHint = '출생일자를 입력하세요';
  String adoption = 'YYYY-MM-DD';
  String adoptionHint = '입양일자를 입력하세요';
  String breed = '요크셔테리어';
  String breedHint = '견종을 입력하세요';
  String gender = '수컷';
  String genderHint = '성별을 입력하세요';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(title: Text('반려견 정보 설정')),
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
                    IconButton(
                      iconSize: getBlockSizeHorizontal(20),
                      icon: _userAvatar(),
                      onPressed: _changeImage,
                    ),
                    SizedBox(
                        width: getBlockSizeHorizontal(80),
                        height: getBlockSizeVertical(1)),
                    _subtitle('출생'),
                    customTextField(birth, birthHint, null),
                    _subtitle('입양'),
                    customTextField(adoption, adoptionHint, null),
                    _subtitle('견종'),
                    customTextField(breed, breedHint, null),
                    _subtitle('성별'),
                    customTextField(gender, genderHint, null),
                    SizedBox(height: getBlockSizeVertical(5)),
                    DefaultButton(text: '확인', press: _changeProfile),
                    SizedBox(height: getBlockSizeVertical(1)),
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

  void _changeProfile() {
    print('change profile tapped');
  }
}
