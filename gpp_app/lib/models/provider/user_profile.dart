import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/util/my_logger.dart';

class UserProfile with ChangeNotifier {
  String accessToken;
  String firstName;
  String lastName;
  String email;
  int id;
  int petId;
  int ppcamId;
  int padId;

  @override
  String toString() {
    return 'UserProfile: $firstName, $lastName, $email, user: $id, pet: $petId, ppcam: $ppcamId, pad: $padId, $accessToken}';
  }

  void reset() {
    accessToken = null;
    firstName = null;
    lastName = null;
    email = null;
    id = null;
    petId = null;
    ppcamId = null;
    padId = null;
    MyLogger.info('UserProfile reseted: ${toString()}');
    notifyListeners();
  }

  void setUserAuth(UserAuth userAuth) {
    accessToken = userAuth.accessToken;
    firstName = userAuth.user.firstName;
    lastName = userAuth.user.lastName;
    email = userAuth.user.email;
    id = userAuth.user.id;
    petId = userAuth.pet.id;
    // no ppcamId
    // no padId
    // init later
  }
}
