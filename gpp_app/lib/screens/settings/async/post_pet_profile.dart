import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:gpp_app/models/json/pet_model.dart';
import 'package:gpp_app/models/network/dio_client.dart';
import 'package:gpp_app/models/network/user_auth_interceptor.dart';
import 'package:gpp_app/util/my_logger.dart';
import 'package:gpp_app/widgets/yes_alert_dialog.dart';

Future<int> postPetProfile(
  BuildContext context,
  PetModel petModel,
) async {
  final Dio _dio = Dio();
  final DioClient dioClient = DioClient(_dio);
  Response response;
  // host/pet/register POST
  try {
    response = await dioClient.post(
      DioClient.serverUrl + 'pet/register',
      data: {
        'user_id': petModel.userId,
        'name': petModel.name,
        'breed': petModel.breed,
        'gender': petModel.genderStr,
        'birth': petModel.birth.toString(),
        'adoption': petModel.adoption.toString(),
      },
      interceptor: UserAuthInterceptor(context, _dio),
    );
    // Handling exception
  } on DioError {
    MyLogger.error('PUT pet profile failed by error');
    return null;
  }
  // PUT Successed
  MyLogger.debug('response data : ${response.data}');
  return PetModel.fromJson(response.data).id;
}
