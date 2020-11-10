import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

class PetRecordApi {
  PetRecordApi._();

  static Future<List<PetRecord>> getAll(
    BuildContext context,
    String uri,
    String date,
  ) async {
    Dio _dio = Dio();
    final DioClient dioClient = DioClient(_dio);
    Response response;
    try {
      response = await dioClient.get(
        uri,
        queryParameters: {
          'timestamp': date,
        },
        interceptor: UserAuthInterceptor(context, _dio),
      );
      // Handling exception
    } on DioError catch (e) {
      throw e; // to return error on future
    }

    // GET Successed
    MyLogger.debug('PetRecords response.data : ${response.data}');
    // Parse json to return value
    List<PetRecord> petRecords = [];
    for (int i = 0; i < response.data.length; i++) {
      petRecords.add(PetRecord.fromJson(response.data[i]));
    }
    MyLogger.debug('PetRecords return value : ${petRecords.runtimeType}');
    return petRecords;
  }

  static Future<void> put(
    BuildContext context,
    String uri,
    String timestamp,
    String result,
  ) async {
    final Dio _dio = Dio();
    final DioClient dioClient = DioClient(_dio);
    Response response;
    try {
      response = await dioClient.put(
        uri,
        data: {
          'timestamp': timestamp, // same
          'result': result,
        },
        queryParameters: {
          'timestamp': timestamp, // same
        },
        interceptor: UserAuthInterceptor(context, _dio),
      );
      // Handling exception
    } on DioError {
      MyLogger.error('PUT pet record failed by error');
    }

    // PUT Successed
    // MyLogger.debug(
    //     'PUT success code is ${response.statusCode}. So there is no resp body. ${response.data}');
    MyLogger.debug(
        'PUT success code is ${response.statusCode}.\n${response.data}');
  }
}
