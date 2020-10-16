// import 'package:dio/dio.dart';
// import 'package:flutter/widgets.dart';
// import 'package:gpp_app/models/network/dio_client.dart';
// import 'package:gpp_app/util/my_logger.dart';

// void putPet(BuildContext context, String email, String pw) async {
//   final DioClient dioClient = DioClient(Dio());
//   MyLogger.info('Login button tapped');
//   // ========== MUST BE DELETED AFTER FINISH LINKING REST API ==============
//   MyLogger.debug('ID: $email, PW: $pw');
//   Response response;
//   // host/user/login POST
//   try {
//     response = await dioClient.post(
//       DioClient.serverUrl + 'user/login',
//       data: {
//         'email': email,
//         'password': pw,
//       },
//     );
//     // Handling exception
//   } on DioError catch (e) {
//     showNoAlertDialog(
//       context,
//       '아이디 또는 비밀번호를\n확인하세요',
//       () => Navigator.of(context).pop(),
//     );
//     return;
//   }
//   // POST Successed
//   if (response != null && response.statusCode == 200) {
//     MyLogger.info('Login successed');

//     MyLogger.debug('response data : ${response.data}');
//     // Dio.post returns map
//     UserAuth userAuth = UserAuth.fromJson(response.data);
//     MyLogger.debug('$userAuth');

//     UserProfile userProfile = Provider.of<UserProfile>(context, listen: false);
//     userProfile.setUserAuth(userAuth);
//     PetProfile petProfile = Provider.of<PetProfile>(context, listen: false);
//     petProfile.setUserAuth(userAuth);
//     MyLogger.debug('$userProfile');
//     MyLogger.debug('$petProfile');

//     // Route to report(main) screen
//     Navigator.of(context).pushNamed(Routes.report);
//   }
// }
