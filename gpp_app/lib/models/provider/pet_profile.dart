import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/util/my_logger.dart';

enum Gender { male, female }

class PetProfile with ChangeNotifier {
  int id;
  String name;
  String breed;
  Gender _gender;
  DateTime birth;
  DateTime adoption;

  Gender get gender => _gender;

  set genderStr(String gender) {
    // String to Gender
    if (gender == 'male') {
      _gender = Gender.male;
    } else if (gender == 'female') {
      _gender = Gender.female;
    }
  }

  set genderEnum(Gender gender) {
    _gender = gender;
  }

  @override
  String toString() {
    return 'PetProfile: $id, $name, $breed, $gender, $birth, $adoption';
  }

  void reset() {
    id = null;
    name = null;
    breed = null;
    _gender = null;
    birth = null;
    adoption = null;
    MyLogger.info('PetProfile reseted : ${toString()}');
    notifyListeners();
  }

  void setUserAuth(UserAuth userAuth) {
    id = userAuth.pet.id;
    name = userAuth.pet.name;
    breed = userAuth.pet.breed;
    String genderString = userAuth.pet.gender;
    // String to Gender
    if (genderString == 'male') {
      _gender = Gender.male;
    } else if (genderString == 'female') {
      _gender = Gender.female;
    }
    birth = userAuth.pet.birth;
    adoption = userAuth.pet.adoption;
  }
}
