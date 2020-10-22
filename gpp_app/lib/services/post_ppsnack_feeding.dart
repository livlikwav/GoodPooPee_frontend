import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<void> postPpsnackFeeding(
  BuildContext context,
  int ppcamId,
) async {
  final Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  try {
    response = await dioClient.post(
      DioClient.serverUrl + 'ppcam/' + ppcamId.toString() + '/ppsnack/feeding',
      data: {},
      interceptor: UserAuthInterceptor(context, _dio),
    );
    // Handling exception
  } on DioError catch (e) {
    throw e; // to return error on future
  }

  // POST Successed
  MyLogger.debug('Success Ppsnack feeding response.data : ${response.data}');
}
