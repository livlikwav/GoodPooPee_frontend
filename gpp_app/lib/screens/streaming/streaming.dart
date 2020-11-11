import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gpp_app/models/json/ppcam_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
import 'package:gpp_app/models/provider/user_profile.dart';
import 'package:gpp_app/screens/streaming/components/custom_streaming_menu.dart';
import 'package:gpp_app/services/ppcam_api.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/streaming/alert_scafold.dart';
import 'package:gpp_app/widgets/streaming/custom_vlc_controller.dart';
import 'package:gpp_app/widgets/streaming/ip_debug_button.dart';
import 'package:gpp_app/widgets/streaming/live_video.dart';
import 'package:provider/provider.dart';

class StreamingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StreamingScreenState();
}

class _StreamingScreenState extends State<StreamingScreen> {
  PpcamProfile _ppcamProfile;
  bool isPpcamProfileNull;
  Future<PpcamModel> _ppcamModel;
  CustomVlcPlayerController _controller;

  @override
  void initState() {
    _ppcamProfile = Provider.of<PpcamProfile>(context, listen: false);
    MyLogger.debug('$_ppcamProfile');
    if (_ppcamProfile.id == null) {
      isPpcamProfileNull = true;
      // GET ppcam profile
      int userId = Provider.of<UserProfile>(context, listen: false).id;
      _ppcamModel = PpcamApi.get(
        context,
        DioClient.serverUrl + 'user/' + userId.toString() + '/ppcam',
      );
    } else {
      isPpcamProfileNull = false;
    }

    // init controller
    _controller = CustomVlcPlayerController(
      onInit: () {
        _controller.play();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // set Landscape orientation at every build time
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    return isPpcamProfileNull
        // Server request
        ? FutureBuilder(
            future: _ppcamModel,
            builder:
                (BuildContext context, AsyncSnapshot<PpcamModel> snapshot) {
              Widget child;
              // Future complete with data
              if (snapshot.hasData) {
                child = _getBody(context, _controller, snapshot.data.ipAddress,
                    snapshot.data.id);
                // Future complete with error
              } else if (snapshot.hasError) {
                DioError error = snapshot.error;
                if (error.response != null &&
                    error.response.statusCode == 404) {
                  child = alertScafold(context, '사용하는 푸피캠을 연결해주세요');
                  // Unknown error
                } else {
                  child = alertScafold(context, '푸피캠 정보를 불러오는 중 오류가 발생했습니다');
                }
                // Future incomplete
              } else {
                child = Center(child: CircularProgressIndicator());
              }
              return child;
            },
          )
        // Already have ppcam profile
        : _getBody(
            context, _controller, _ppcamProfile.ipAddress, _ppcamProfile.id);
  }

  @override
  void dispose() {
    // set Landscape orientation
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }
}

Widget _getBody(BuildContext context, CustomVlcPlayerController controller,
    String ppcamUrl, int ppcamId) {
  // ============ FOR TEST ===============
  // ppcamUrl = 'http://beachreachpeach.iptime.org:9981';
  // ppcamUrl =
  //     'https://gpp-images-1.s3.ap-northeast-2.amazonaws.com/gpp_streaming.MOV';
  // ppcamUrl = 'http://172.16.101.111:8090';
  // =====================================
  return Scaffold(
    primary: true,
    floatingActionButton: CustomStreamingMenu(controller, ppcamId),
    body: Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: IpDebugButton(),
        ),
        LiveVideo(ppcamUrl, controller),
      ],
    ),
  );
}
