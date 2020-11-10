import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/ppcam_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/yes_alert_dialog.dart';
import 'package:provider/provider.dart';

class PpcamApi {
  PpcamApi._();

  static Future<PpcamModel> get(
    BuildContext context,
    String uri,
  ) async {
    final Dio _dio = Dio();
    final DioClient dioClient = DioClient(_dio);
    Response response;
    try {
      response = await dioClient.get(
        uri,
        queryParameters: {},
        interceptor: UserAuthInterceptor(context, _dio),
      );
      // Handling exception
    } on DioError catch (e) {
      throw e; // to return error on future
    }

    // GET Successed
    MyLogger.debug('Ppcam response.data : ${response.data}');
    PpcamModel ppcamModel = PpcamModel.fromJson(response.data);
    MyLogger.debug('$ppcamModel');
    // Update provider
    Provider.of<PpcamProfile>(context, listen: false).setPpcamModel(ppcamModel);
    return ppcamModel;
  }

  static Future<void> put(
    BuildContext context,
    String uri,
    int userId,
    String ppcamUrl,
  ) async {
    final Dio _dio = Dio();
    final DioClient dioClient = DioClient(_dio);
    Response response;
    try {
      response = await dioClient.put(
        uri,
        data: {
          'user_id': userId,
          'ip_address': ppcamUrl,
        },
        queryParameters: {},
        interceptor: UserAuthInterceptor(context, _dio),
      );
      // Handling exception
    } on DioError {
      MyLogger.error('PUT ppcam failed by error');
    }

    // PUT Successed
    MyLogger.debug(
        'PUT success code is ${response.statusCode}. So there is no resp body. ${response.data}');
  }
}
