import 'package:flutter/material.dart';
import 'package:gpp_app/constants/assets.dart';
import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/custom_text_field.dart';
import 'package:gpp_app/widgets/default_button.dart';
import 'package:gpp_app/widgets/yes_alert_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SettingPetProfileScreen extends StatefulWidget {
  @override
  _SettingPetProfileScreenState createState() =>
      _SettingPetProfileScreenState();
}

class _SettingPetProfileScreenState extends State<SettingPetProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController breedController = TextEditingController();
  // Unfixed
  PetProfile _petProfile;
  DateTime _birthDate;
  DateTime _adoptionDate;
  String _name;
  String _breed;
  Gender _gender;
  // Fixed strings
  final String birthSubtitle = '출생 일자';
  final String adoptionSubtitle = '입양 일자';
  final String nameSubtitle = '이름';
  final String breedSubtitle = '견종';
  final String genderSubtitle = '성별';
  final String nameHint = '반려견의 이름을 입력하세요';
  final String breedHint = '견종을 입력하세요';

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _petProfile = Provider.of<PetProfile>(context, listen: false);
    _birthDate = _petProfile.birth ?? DateTime.now();
    _adoptionDate = _petProfile.adoption ?? DateTime.now();
    _name = _petProfile.name ?? '';
    _breed = _petProfile.breed ?? '';
    _gender = _petProfile.gender ?? Gender.male;
  }

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
                    // IconButton(
                    //   iconSize: getBlockSizeHorizontal(20),
                    //   icon: _userAvatar(),
                    //   onPressed: _changeImage,
                    // ),
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
                    customTextField(_name, nameHint, nameController),
                    _subtitle(breedSubtitle),
                    customTextField(_breed, breedHint, breedController),
                    _subtitle(genderSubtitle),
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

  void _changeProfile() {
    MyLogger.info('Change pet profile button tapped');

    _petProfile.birth = _birthDate;
    _petProfile.adoption = _adoptionDate;
    _petProfile.name =
        nameController.text == '' ? _petProfile.name : nameController.text;
    _petProfile.breed =
        breedController.text == '' ? _petProfile.breed : breedController.text;
    _petProfile.gender = _gender;
    MyLogger.debug('petProfile : $_petProfile');

    showYesAlertDialog(context, '', () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      // Navigator.of(context).pushNamed(Routes.login);
    });
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
      initialDate: _birthDate, // Refer step 1
      firstDate: DateTime(2005),
      lastDate: DateTime.now(),
      helpText: '기록을 확인할 날짜를 선택하세요.',
      locale: Locale('ko', 'KO'),
    );
    if (picked != null && picked != _birthDate)
      setState(() {
        _birthDate = picked;
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
}

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
