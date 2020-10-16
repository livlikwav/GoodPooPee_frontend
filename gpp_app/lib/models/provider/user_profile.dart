import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';

class UserProfile with ChangeNotifier {
  String _accessToken;
  String _firstName;
  String _lastName;
  String _email;
  int _id;
  int _petId;
  int _ppcamId;
  int _padId;

  String get accessToken => _accessToken;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  int get id => _id;
  int get petId => _petId;
  int get ppcamId => _ppcamId;
  int get padId => _padId;

  @override
  String toString() {
    return '$_firstName, $_lastName, $_email, user: $_id, pet: $_petId, ppcam: $_ppcamId, pad: $_padId, $_accessToken}';
  }

  void reset() {
    _accessToken = null;
    _firstName = null;
    _lastName = null;
    _email = null;
    _id = null;
    _petId = null;
    _ppcamId = null;
    _padId = null;
    MyLogger.info('UserProfile reseted: ${toString()}');
    notifyListeners();
  }

  void put({
    String accessToken,
    String firstName,
    String lastName,
    String email,
    int id,
    int petId,
    int ppcamId,
    int padId,
  }) {
    _accessToken = accessToken;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _id = id;
    _petId = petId;
    _ppcamId = ppcamId;
    _padId = padId;
    notifyListeners();
  }
}
