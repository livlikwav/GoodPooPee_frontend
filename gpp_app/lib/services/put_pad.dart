import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/pad_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/check_dialog.dart';
import 'package:provider/provider.dart';

void putPad(
  BuildContext context,
  PadModel padModel,
) async {
  final Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  // host/ppcam/<int:ppcam_id>/pad PUT
  int ppcamId = Provider.of<PpcamProfile>(context, listen: false).id;
  try {
    response = await dioClient.put(
      DioClient.serverUrl + 'ppcam/' + ppcamId.toString() + '/pad',
      data: {
        'lux': padModel.lux,
        'luy': padModel.luy,
        'ldx': padModel.ldx,
        'ldy': padModel.ldy,
        'rdx': padModel.rdx,
        'rdy': padModel.rdy,
        'rux': padModel.rux,
        'ruy': padModel.ruy,
      },
      interceptor: UserAuthInterceptor(context, _dio),
    );
    // Handling exception
  } on DioError {
    MyLogger.error('PUT pad profile failed by error');
    return;
  }
  // PUT Successed
  MyLogger.debug(
      'PUT success code is ${response.statusCode}. So there is no resp body. ${response.data}');
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return CheckDialog(
        onTapFunc: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    },
  );
}
