import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/pet_record.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';

Future<List<PetRecord>> getPetRecords(
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
