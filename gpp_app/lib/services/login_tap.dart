import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/pet_profile.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/no_alert_dialog.dart';
import 'package:provider/provider.dart';

void loginTapped(BuildContext context, String email, String pw) async {
  final DioClient dioClient = DioClient(Dio());
  MyLogger.info('Login button tapped');
  // ========== MUST BE DELETED AFTER FINISH LINKING REST API ==============
  MyLogger.debug('ID: $email, PW: $pw');
  Response response;
  // host/user/login POST
  try {
    response = await dioClient.post(
      DioClient.serverUrl + 'user/login',
      data: {
        'email': email,
        'password': pw,
      },
    );
    // Handling exception
  } on DioError {
    showNoAlertDialog(
      context,
      '아이디 또는 비밀번호를\n확인하세요',
      () => Navigator.of(context).pop(),
    );
    return;
  }
  // POST Successed
  MyLogger.info('Login successed');
  MyLogger.debug('response data : ${response.data}');
  // Dio.post returns map
  UserAuth userAuth = UserAuth.fromJson(response.data);
  MyLogger.debug('$userAuth');
  // Update providers
  Provider.of<UserProfile>(context, listen: false).setUserAuth(userAuth);
  Provider.of<PetProfile>(context, listen: false).setUserAuth(userAuth);
  // Route to report(main) screen
  Navigator.of(context).pushReplacementNamed(Routes.home);
}
