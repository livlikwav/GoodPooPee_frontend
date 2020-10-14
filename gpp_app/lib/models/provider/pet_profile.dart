import 'package:flutter/material.dart';

enum Gender { male, female }

class PetProfile with ChangeNotifier {
  String name;
  String breed;
  Gender gender;
  DateTime birth;
  DateTime adoption;
}
