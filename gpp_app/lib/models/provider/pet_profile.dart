import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';

enum Gender { male, female }

class PetProfile with ChangeNotifier {
  String name;
  String breed;
  Gender gender;
  DateTime birth;
  DateTime adoption;

  @override
  String toString() {
    return '${name ?? null}, ${breed ?? null}, $gender, $birth, $adoption';
  }

  void reset() {
    name = null;
    breed = null;
    gender = null;
    birth = null;
    adoption = null;
    MyLogger.info('UserProfile reseted');
    notifyListeners();
  }
}
