import 'package:flutter/material.dart';
import 'package:gpp_app/util/my_logger.dart';

class UserProfile with ChangeNotifier {
  String accessToken;

  final Map<String, int> ids = {
    'userId': null,
    'petId': null,
    'ppcamId': null,
    'padId': null,
  };
  final Map<String, String> names = {
    'userFirstName': null,
    'userLastName': null,
    'userEmail': null,
  };

  @override
  String toString() {
    return '$ids, $names, $accessToken}';
  }

  void reset() {
    accessToken = null;
    ids['userId'] = null;
    ids['petId'] = null;
    ids['ppcamId'] = null;
    ids['padId'] = null;
    names['userFirstName'] = null;
    names['userLastName'] = null;
    names['userEmail'] = null;
    MyLogger.info('UserProfile reseted');
    notifyListeners();
  }
}
