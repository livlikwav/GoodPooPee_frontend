import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/ppcam_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/services/ppcam_api.dart';
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
    this.id = null;
    this.userId = null;
    this.ipAddress = null;
    this.serialNum = null;
    MyLogger.info('PpcamProfile reseted -> ${toString()}');
    notifyListeners();
  }

  void setPpcamModel(PpcamModel ppcamModel) {
    this.id = ppcamModel.id;
    this.userId = ppcamModel.userId;
    this.ipAddress = ppcamModel.ipAddress;
    this.serialNum = ppcamModel.serialNum;
    MyLogger.info('PpcamProfile set by model -> ${toString()}');
  }

  Future<void> updateIpAddress(BuildContext context, String ipAddress) async {
    this.ipAddress = ipAddress;
    await PpcamApi.put(
      context,
      DioClient.serverUrl + 'ppcam/' + id.toString(),
      userId,
      ipAddress,
    );
  }
}
