import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/ppcam_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/models/provider/ppcam_profile.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:provider/provider.dart';

Future<PpcamModel> getPpcam(
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
