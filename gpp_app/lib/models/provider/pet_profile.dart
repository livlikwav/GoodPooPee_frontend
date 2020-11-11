import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/pet_model.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/util/my_logger.dart';

enum Gender { male, female }

class PetProfile with ChangeNotifier {
  int id;
  int userId;
  String name;
  String breed;
  Gender gender;
  DateTime birth;
  DateTime adoption;

  String get genderStr => gender.toString().split('.')[1];

  @override
  String toString() {
    return 'PetProfile: pet: $id, user: $userId, $name, $breed, $gender, $birth, $adoption';
  }

  void reset() {
    id = null;
    userId = null;
    name = null;
    breed = null;
    gender = null;
    birth = null;
    adoption = null;
    MyLogger.info('PetProfile reseted : ${toString()}');
    notifyListeners();
  }

  void setUserAuth(UserAuth userAuth) {
    id = userAuth.pet.id;
    userId = userAuth.user.id; // Pet model user Id is null *
    name = userAuth.pet.name;
    breed = userAuth.pet.breed;
    gender = userAuth.pet.gender;
    birth = userAuth.pet.birth;
    adoption = userAuth.pet.adoption;
    MyLogger.debug('${toString()}');
  }

  void setPetModel(PetModel petModel) {
    id = petModel.id;
    userId = petModel.userId;
    name = petModel.name;
    breed = petModel.breed;
    gender = petModel.gender;
    birth = petModel.birth;
    adoption = petModel.adoption;
  }
}
