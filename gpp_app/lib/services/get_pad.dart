import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/pad_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<PadModel> getPad(
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
    // throw e; // to return error on future
    if (e.response != null && e.response.statusCode == 404) {
      // return default values
      MyLogger.debug('404: Pad not found');
      throw e;
    } else {
      MyLogger.error('GET pad unknown error');
      throw e;
    }
  }

  // GET Successed
  MyLogger.debug('Pad response.data : ${response.data}');
  PadModel padModel = PadModel.fromJson(response.data);
  MyLogger.debug('$padModel');
  // Update provider
  // Provider.of<PpcamProfile>(context, listen: false).setPpcamModel(ppcamModel);
  return padModel;
}
