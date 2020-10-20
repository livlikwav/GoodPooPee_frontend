import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_model.dart';
import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/screens/settings/async/post_pet_profile.dart';
import 'package:gpp_app/screens/settings/async/put_pet_profile.dart';
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
  UserProfile _userProfile;
  PetModel _petModel;
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
    _userProfile = Provider.of<UserProfile>(context, listen: false);
    _petModel = PetModel.petProfile(_petProfile);
    MyLogger.debug('$_petProfile');
    MyLogger.debug('$_petModel');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: true,
        appBar: AppBar(title: Text('반려견 정보 설정')),
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
                    customTextField(_petModel.name, nameHint, nameController),
                    _subtitle(breedSubtitle),
                    customTextField(
                        _petModel.breed, breedHint, breedController),
                    _subtitle(genderSubtitle),
                    Container(
                      margin: EdgeInsets.all(getBlockSizeHorizontal(1)),
                      child: Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              title: Text('♂️'),
                              leading: Radio(
                                value: Gender.male,
                                groupValue: _petModel.gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _petModel.gender = value;
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
                                groupValue: _petModel.gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _petModel.gender = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
    // Update by textfield values
    _petModel.name =
        nameController.text == '' ? _petProfile.name : nameController.text;
    _petModel.breed =
        breedController.text == '' ? _petProfile.breed : breedController.text;
    // Avoid to null error in _petProfile.setPetModel
    _petModel.birth ??= DateTime.now();
    _petModel.adoption ??= DateTime.now();
    // update PetProfile provider
    _petProfile.setPetModel(_petModel);
    MyLogger.debug('$_petProfile');
    // PUT pet profile
    if (_petProfile.id != null) {
      putPetProfile(context, _petModel);
    } else {
      // If null, POST new pet profile
      postPetProfile(context, _petModel);
    }
  }

  Flexible _birthPick(String subtitle) {
    return Flexible(
      child: Column(
        children: [
          _subtitle(subtitle),
          FlatButton(
            child: Text(_formatDate(_petModel.birth ?? DateTime.now())),
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
            child: Text(_formatDate(_petModel.adoption ?? DateTime.now())),
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
      initialDate: _petModel.birth ?? DateTime.now(), // Refer step 1
      firstDate: DateTime(2005),
      lastDate: DateTime.now(),
      helpText: '기록을 확인할 날짜를 선택하세요.',
      locale: Locale('ko', 'KO'),
    );
    if (picked != null && picked != _petModel.birth)
      setState(() {
        _petModel.birth = picked;
      });
  }

  void _selectAdoption(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _petModel.adoption ?? DateTime.now(), // Refer step 1
      firstDate: DateTime(2005),
      lastDate: DateTime.now(),
      helpText: '기록을 확인할 날짜를 선택하세요.',
      locale: Locale('ko', 'KO'),
    );
    if (picked != null && picked != _petModel.adoption)
      setState(() {
        _petModel.adoption = picked;
      });
  }
}

// CircleAvatar _userAvatar() {
//   return CircleAvatar(
//     radius: getBlockSizeHorizontal(20),
//     backgroundImage: new AssetImage(Assets.appLogo),
//   );
// }

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
