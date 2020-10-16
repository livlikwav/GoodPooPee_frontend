import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';

enum Gender { male, female }

class PetProfile with ChangeNotifier {
  String _name;
  String _breed;
  Gender _gender;
  DateTime _birth;
  DateTime _adoption;

  String get name => _name;
  String get breed => _breed;
  Gender get gender => _gender;
  DateTime get birth => _birth;
  DateTime get adoption => _adoption;

  @override
  String toString() {
    return '$_name, $_breed, $_gender, $_birth, $_adoption';
  }

  void reset() {
    _name = null;
    _breed = null;
    _gender = null;
    _birth = null;
    _adoption = null;
    MyLogger.info('PetProfile reseted : ${toString()}');
    notifyListeners();
  }

  void put({
    String name,
    String breed,
    Gender gender,
    DateTime birth,
    DateTime adoption,
  }) {
    _name = name;
    _breed = breed;
    _gender = gender;
    _birth = birth;
    _adoption = adoption;
    notifyListeners();
  }
}
