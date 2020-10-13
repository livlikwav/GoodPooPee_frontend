import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/default_button.dart';
import 'package:intl/intl.dart';

class SettingPetProfileScreen extends StatefulWidget {
  @override
  _SettingPetProfileScreenState createState() =>
      _SettingPetProfileScreenState();
}

class _SettingPetProfileScreenState extends State<SettingPetProfileScreen> {
  DateTime _birthDate = DateTime.now();
  DateTime _adoptionDate = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  Gender _gender = Gender.male;

  // Fixed strings
  final String nameSubtitle = '이름';
  final String nameEx = '예시: 포동이';
  final String nameHint = '반려견의 이름을 입력하세요';
  final String adoptionSubtitle = '입양 일자';
  final String birthSubtitle = '출생 일자';
  final String breedSubtitle = '견종';
  final String breedEx = '예시: 요크셔테리어';
  final String breedHint = '견종을 입력하세요';
  final String genderSubtitle = '성별';
  final String genderEx = '수컷';
  final String genderHint = '성별을 입력하세요';

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
                      height: getBlockSizeVertical(1),
                    ),
                    Row(
                      children: [
                        _birthPick(birthSubtitle),
                        _adoptionPick(adoptionSubtitle),
                      ],
                    ),
                    _subtitle(nameSubtitle),
                    customTextField(nameEx, nameHint, nameController),
                    _subtitle(breedSubtitle),
                    customTextField(breedEx, breedHint, breedController),
                    Container(
                      margin: EdgeInsets.all(getBlockSizeHorizontal(1)),
                      child: Row(
                        children: [
                          // Flexible(
                          //   child: _subtitle(genderSubtitle),
                          // ),
                          Flexible(
                            child: ListTile(
                              title: Text('♂️'),
                              leading: Radio(
                                value: Gender.male,
                                groupValue: _gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: ListTile(
                              title: const Text('♀️'),
                              leading: Radio(
                                value: Gender.female,
                                groupValue: _gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // _subtitle(genderSubtitle),
                    // customTextField(genderEx, genderHint, null),
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

  void _changeImage() {
    print('change image tapped');
  }

  void _changeProfile() {
    MyLogger.info('Change pet profile button tapped');

    MyLogger.debug('${_formatDate(_birthDate)}, ${_formatDate(_adoptionDate)}');
    MyLogger.debug('${nameController.text}, ${breedController.text}');
    MyLogger.debug('$_gender');
  }

  Flexible _birthPick(String subtitle) {
    return Flexible(
      child: Column(
        children: [
          _subtitle(subtitle),
          FlatButton(
            child: Text(_formatDate(this._birthDate)),
            onPressed: () {
              _selectBirth(context);
            },
          ),
        ],
      ),
    );
  }

  Flexible _adoptionPick(String subtitle) {
    return Flexible(
      child: Column(
        children: [
          _subtitle(subtitle),
          FlatButton(
            child: Text(_formatDate(this._adoptionDate)),
            onPressed: () {
              _selectAdoption(context);
            },
          ),
        ],
      ),
    );
  }

  void _selectBirth(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this._birthDate, // Refer step 1
      firstDate: DateTime(2005),
      lastDate: DateTime.now(),
      helpText: '기록을 확인할 날짜를 선택하세요.',
      locale: Locale('ko', 'KO'),
    );
    if (picked != null && picked != this._birthDate)
      setState(() {
        this._birthDate = picked;
      });
  }

  void _selectAdoption(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: this._adoptionDate, // Refer step 1
      firstDate: DateTime(2005),
      lastDate: DateTime.now(),
      helpText: '기록을 확인할 날짜를 선택하세요.',
      locale: Locale('ko', 'KO'),
    );
    if (picked != null && picked != this._adoptionDate)
      setState(() {
        this._adoptionDate = picked;
      });
  }

  Widget _genderPick() {
    return null;
  }
}

enum Gender { male, female }

CircleAvatar _userAvatar() {
  return CircleAvatar(
    radius: getBlockSizeHorizontal(20),
    backgroundImage: new AssetImage(Assets.appLogo),
  );
}

String _formatDate(DateTime datetime) {
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(datetime);
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
