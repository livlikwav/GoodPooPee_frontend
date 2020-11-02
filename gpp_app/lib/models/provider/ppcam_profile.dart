import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/ppcam_model.dart';
import 'package:gpp_app/util/my_logger.dart';

class PpcamProfile with ChangeNotifier {
  int id;
  int userId;
  String ipAddress;
  String serialNum;

  @override
  String toString() {
    return 'PpcamProfile: pet: $id, user: $userId, $ipAddress, $serialNum';
  }

  void reset() {
    id = null;
    userId = null;
    ipAddress = null;
    serialNum = null;
    MyLogger.info('PpcamProfile reseted -> ${toString()}');
    notifyListeners();
  }

  void setPpcamModel(PpcamModel ppcamModel) {
    id = ppcamModel.id;
    userId = ppcamModel.userId;
    ipAddress = ppcamModel.ipAddress;
    serialNum = ppcamModel.serialNum;
    MyLogger.info('PpcamProfile set by model -> ${toString()}');
  }
}
