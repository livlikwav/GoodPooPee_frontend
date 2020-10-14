import 'package:flutter/material.dart';

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
}
