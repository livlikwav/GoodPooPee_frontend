import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/models/network/dio_client.dart';
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
  } on DioError catch (e) {
    if (e.response != null) {
      MyLogger.error('Login failed. Status code is ${e.response.statusCode}');
      showNoAlertDialog(
        context,
        '아이디 또는 비밀번호를\n확인하세요',
        () => Navigator.of(context).pop(),
      );
      return;
    } else {
      MyLogger.error(
          'Login failed. Error.response is null.\n${e.request}\n${e.message}');
      return;
    }
  }
  // POST Successed
  if (response != null && response.statusCode == 200) {
    MyLogger.info('Login successed');

    MyLogger.debug('response data : ${response.data}');
    // Dio.post returns map
    UserAuth userAuth = UserAuth.fromJson(response.data);
    MyLogger.debug('$userAuth');

    UserProfile userProfile = Provider.of<UserProfile>(context, listen: false);
    userProfile.put(
      firstName: userAuth.user.firstName,
      lastName: userAuth.user.lastName,
      email: userAuth.user.email,
      accessToken: userAuth.accessToken,
      id: userAuth.user.id,
      petId: userAuth.pet.id,
    );
    MyLogger.debug('$userProfile');

    // Route to report(main) screen
    Navigator.of(context).pushNamed(Routes.report);
  }
}
