import 'package:flutter/material.dart';
import 'package:gpp_app/models/json/user_auth.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/routes.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/util/size_config.dart';
import 'package:gpp_app/widgets/empty_app_bar_widget.dart';
// link rest api
import 'package:dio/dio.dart';
import 'package:gpp_app/widgets/no_alert_dialog.dart';
import 'package:provider/provider.dart';
// build screen
import 'components/upside.dart';
import 'components/center_side.dart';
import 'components/downside.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final DioClient dioClient = DioClient(Dio());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(), //empty_app_bar_widget
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: SizedBox(
        height: getBlockSizeVertical(90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(flex: 5, child: buildUpSide()),
            Expanded(
                flex: 3,
                child: buildCenterSide(
                  loginTapped,
                  emailController,
                  passwordController,
                )),
            Expanded(flex: 2, child: buildDownSide(context, registerTapped)),
          ],
        ),
      ),
    );
  }

  void loginTapped() async {
    MyLogger.info('Login button tapped');
    // ========== MUST BE DELETED AFTER FINISH LINKING REST API ==============
    MyLogger.debug(
        'ID: ${emailController.text}, PW: ${passwordController.text}');
    Response response;
    // host/user/login POST
    try {
      response = await dioClient.post(
        DioClient.serverUrl + 'user/login',
        data: {
          'email': emailController.text,
          'password': passwordController.text
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

      UserProfile userProfile =
          Provider.of<UserProfile>(context, listen: false);
      userProfile.put(
        accessToken: userAuth.access_token,
        id: userAuth.user_id,
        petId: userAuth.pet_id,
        ppcamId: userAuth.ppcam_id,
      );
      // MyLogger.debug('${userProfile.ids}');
      // MyLogger.debug('${userProfile.accessToken}');

      // Route to report(main) screen
      Navigator.of(context).pushNamed(Routes.report);
    }
  }

  void registerTapped() {
    MyLogger.info('Register link tapped');
    Navigator.of(context).pushNamed(Routes.register);
  }
}
